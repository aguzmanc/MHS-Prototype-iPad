#import "PhotoService.h"

@implementation PhotoService

#pragma mark - Initialization

-(id)initWithProfileImageReceiverDelegate:(id<AsyncProfileImageReceiverDelegate>) delegate 
                         andProfileNumber:(NSString *)profileNumber
{
	self = [super init];
	
	_delegate = delegate;
    _profileNumber = profileNumber;
	
	return self;
}


#pragma mark - Public Methods

-(void)obtainImageForFile:(NSString *)fileName
{
    NSString * requestURL = [NSString stringWithFormat:@"%@%@", PHOTO_DIRECTORY_URL, fileName];
	
	_responseData = [[NSMutableData data] retain];
	
	NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL] ];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];
}



- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
	NSHTTPURLResponse *HTTPresponse = (NSHTTPURLResponse *)response; 
	NSInteger statusCode = [HTTPresponse statusCode]; 
	if ( 404 == statusCode || 500 == statusCode ) {
		NSLog(@"Server Error - %@", [ NSHTTPURLResponse localizedStringForStatusCode: statusCode ]);
        
        [_delegate receiveImageErrorForProfileNumber:_profileNumber];
	} else { 
		[ _responseData setLength:0 ];
	}
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
	[_responseData appendData:data];
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{	
	NSLog(@"%@",[NSString stringWithFormat:@"Connection failed: %@", [error description]]);
    
    [_delegate receiveImageErrorForProfileNumber:_profileNumber];
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{	
	[connection release];
	
	UIImage * image = [UIImage imageWithData:_responseData];
    
    [_delegate receiveImage:image ForProfileNumber:_profileNumber];
}




@end

