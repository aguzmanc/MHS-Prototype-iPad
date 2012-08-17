#import <Foundation/Foundation.h>

@protocol LoginUserServiceDelegate;

@interface LoginUserService : NSObject
{
	NSMutableData * responseData;
	NSMutableString * responseString;
	
	id<LoginUserServiceDelegate> _delegate;
	
}

// Initialization
-(id)initWithDelegate:(id<LoginUserServiceDelegate>)delegate;

// Public Methods
-(void)loginUser:(NSString *)user Pass:(NSString *)pass;


@end


@protocol LoginUserServiceDelegate

-(void)loginStatus:(BOOL)status AndMessage:(NSString *)message;


@end