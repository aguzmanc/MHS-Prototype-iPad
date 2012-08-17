#import <Foundation/Foundation.h>

#import "JSON.h"
#import "Globals.h"

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
-(void)updateProgressStatus:(int)valor;

@end