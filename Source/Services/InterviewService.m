#import "InterviewService.h"
#import "JSON.h"

@implementation InterviewService

#pragma mark - Initialization

-(id)initWithDelegate:(id<AsyncListInterviewReceiverDelegate>) delegate                      
{
	self = [super init];
	
	_delegate = delegate;    
	
	return self;
}






#pragma mark - Public Methods

-(void)requestDataWithUserId:(NSString *)userId
{
    // Build request URL with al parameters
	NSString * requestURL = [NSString stringWithFormat:@"%@?user_id=%@", INTERVIEWS_SERVICE_REQUEST_PAGE, userId];
	
	_responseData = [[NSMutableData data] retain];
    
	NSLog(@"%@", requestURL);
	
	NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
}






#pragma mark - Request Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
	NSHTTPURLResponse *HTTPresponse = (NSHTTPURLResponse *)response; 
	NSInteger statusCode = [HTTPresponse statusCode]; 
	if ( 404 == statusCode || 500 == statusCode ) {
		NSLog(@"Server Error - %@", [ NSHTTPURLResponse localizedStringForStatusCode: statusCode ]);
	} else { 
		[ _responseData setLength:0 ];
	}
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
	[_responseData appendData:data];
    
    //NSLog(@"%@", [[NSMutableString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding]);
    
    int size = [_responseData length];
    
    [_delegate updateInterviewBytesReceived:size];
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{	
    NSLog(@"%@",[NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{	
	[connection release];
	
	NSMutableString * responseString = [[NSMutableString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    
	NSDictionary * jsonDict = [responseString JSONValue];
	NSString * successStr = [jsonDict objectForKey:@"Success"];
    BOOL success  = [successStr isEqualToString:@"True"];
    
    NSMutableArray * interviews = [[NSMutableArray alloc] init];
    
    if(success)
    {
        NSArray * jsonInterviews = (NSArray *)[jsonDict objectForKey:@"Interviews"];
        
        for(NSDictionary * jsonInterview in jsonInterviews)
        {
            Interview * interview = [[Interview alloc] init];
            
            interview.interviewId = [jsonInterview objectForKey:@"interview_id"];
            interview.profileNumber = [jsonInterview objectForKey:@"profile_number"]; 
            
            NSMutableString * dateStr = [jsonInterview objectForKey:@"date"];
            [dateStr appendString:@" "];
            [dateStr appendString:[jsonInterview objectForKey:@"schedule"]];
            
            NSDateFormatter * format = [[[NSDateFormatter alloc] init] autorelease];
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            interview.scheduleDate = [format dateFromString:dateStr];
            
            NSCalendar * cal = [NSCalendar currentCalendar];
            NSDateComponents * comp = [cal components:NSWeekdayCalendarUnit fromDate:interview.scheduleDate];
            
            interview.scheduleWeekday = [comp weekday];
            
            [interviews addObject:interview];
        }
        
        [_delegate receiveInterviews:interviews];
    }
}



@end
