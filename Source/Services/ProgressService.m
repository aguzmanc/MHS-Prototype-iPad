//
//  ProgressService.m
//  MHS Prototype
//
//  Created by Giancarlo on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProgressService.h"
#import "JSON.h"
#import "Globals.h"


@implementation ProgressService

#pragma mark Initialization

-(id)initWithDelegate:(id<ProgressServiceDelegate>)delegate
{
	self = [super init];
	
	_delegate = delegate;
    
	return self;
}


-(void)initProgress:(NSString *) idUser
{

    // Build request URL with al parameters
	//NSString * requestURL = [NSString stringWithFormat:@"%@?user_id=%@", CLIENT_USER_SERVICE_REQUEST_PAGE, idUser];
	NSString * requestURL = @"https://www.quarksocial.net/Mirinda/Apps/App_Cuarto/App/BASES.pdf";
	responseData = [[NSMutableData data] retain];
    
	NSLog(@"%@", requestURL);
	
	NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
	[[NSURLConnection alloc] initWithRequest:request delegate:self];  

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
	totalSize = [NSNumber numberWithLongLong:[response expectedContentLength]];
    NSLog(@"size %i",[totalSize intValue]);
    [_delegate totalService:totalSize];
    NSHTTPURLResponse *HTTPresponse = (NSHTTPURLResponse *)response; 
	NSInteger statusCode = [HTTPresponse statusCode];
	if ( 404 == statusCode || 500 == statusCode ) {
		NSLog(@"Server Error - %@", [ NSHTTPURLResponse localizedStringForStatusCode: statusCode ]);
	} else { 
		[ responseData setLength:0 ];
	}
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{	
    indexProgress = [NSNumber numberWithUnsignedInteger:[data length]];    
    //NSNumber *progress = [NSNumber numberWithFloat:([resourceLength floatValue] / [totalSize floatValue])];
    NSLog(@"receiveData:%i",[indexProgress intValue]);
    
    [_delegate indexService:indexProgress];
    [responseData appendData:data];
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{	
    NSLog(@"%@",[NSString stringWithFormat:@"Connection failed: %@", [error description]]);    
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{	   
    [connection release];
}



@end
