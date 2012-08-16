//
//  SizeUserService.h
//  MHS Prototype
//
//  Created by Giancarlo on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SizeUserServiceDelegate;

@interface SizeUserService : NSObject
{
	NSMutableData * responseData;
	NSMutableString * responseString;
    
	id<SizeUserServiceDelegate> _delegate;
	
}


// Initialization
-(id)initWithDelegate:(id<SizeUserServiceDelegate>)delegate;

// Public Methods
-(void)userService:(NSString *)service UserId:(NSString *)userid;


@end


@protocol SizeUserServiceDelegate

-(void)sizeStatus:(BOOL)status AndMessage:(NSString *)message;

@end