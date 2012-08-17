//
//  SizeUserService.m
//  MHS Prototype
//
//  Created by Giancarlo on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SizeUserService.h"
#import "JSON.h"
#import "Globals.h"

@implementation SizeUserService

#pragma mark Initialization

-(id)initWithDelegate:(id<SizeUserServiceDelegate>)delegate
{
	self = [super init];
	
	_delegate = delegate;
	
	return self;
}

#pragma mark Public Methods

// Public Methods
-(void)userService:(NSString *)service UserId:(NSString *)userid
{
    // Build request URL with al parameters
	NSString * requestURL = [NSString stringWithFormat:@"%@?service=%@&user_id=%@", SIZE_USER_SERVICE_REQUEST_PAGE, service, userid];
	
	responseData = [[NSMutableData data] retain];
    
	NSLog(@"%@", requestURL);
	
	NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
	NSHTTPURLResponse *HTTPresponse = (NSHTTPURLResponse *)response; 
	NSInteger statusCode = [HTTPresponse statusCode]; 
	
    //totalbyte = response.expectedContentLength;
   
   // NSLog(@" total%@",totalbyte);
    if ( 404 == statusCode || 500 == statusCode ) {
		NSLog(@"Server Error - %@", [ NSHTTPURLResponse localizedStringForStatusCode: statusCode ]);
	} else { 
		[ responseData setLength:0 ];
	}
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
	[responseData appendData:data];
             
    recibidobyte  += [responseData length];  
     NSLog(@" recibido%@",recibidobyte);
   // [_delegate updateStatus:recibidobyte];
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{	
	NSLog(@"%@",[NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{	
	[connection release];
	
	responseString = [[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	NSLog(@"%@",responseString);
	NSDictionary * results = [responseString JSONValue];
	NSString * res = [results objectForKey:@"Success"];
	
	BOOL success  = [res isEqualToString:@"True"];
	NSString * reason = nil;
    
    reason = [results objectForKey:@"Size"];
	
	if (success == NO)
		reason = (NSString *)[results objectForKey:@"Reason"];
	
	[_delegate sizeStatus:success AndMessage:reason];
}

@end
