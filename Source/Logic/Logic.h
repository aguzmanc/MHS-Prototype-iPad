#import <Foundation/Foundation.h>

#import "LoginUserService.h"
#import "SizeUserService.h"
#import "Client.h"
#import "Interview.h"

@protocol ViewChangerDelegate;


@interface Logic : NSObject <LoginUserServiceDelegate, SizeUserServiceDelegate>
{
    // delegates
    id<ViewChangerDelegate> _viewChangerDelegate;
    
    // Services
    LoginUserService * _loginUserService;
    SizeUserService  * _sizeUserService;
    
    // Logic data 
    NSArray * _interviewList;
    NSMutableDictionary * _userImageCache;
}

// Properties

@property (strong, nonatomic) NSArray * interviewList;

// Initialization
-(id)initWithViewChangerDelegate:(id<ViewChangerDelegate>)viewChanger;

// Public Methods
-(void)switchToInitialization;
-(void)switchToLogin;
-(void)switchToAssignedInterviews;
-(void)switchToInterview;

-(bool)existsImageForProfileNumber:(NSString *)profileNumber;
-(UIImage *)getImageForProfileNumber:(NSString *)profileNumber;
-(void)obtainImageForProfileNumber:(NSString *)profileNumber;

-(void)loginUser:(NSString *)user Pass:(NSString *)pass;
-(void)userService:(NSString *)service UserId:(NSString *)userid;


@end




/*
 *  VIEW CHANGER DELEGATE
 */

@protocol ViewChangerDelegate

-(void)switchToInitialization;
-(void)switchToAssignedInterviews;
-(void)switchToLogin;
-(void)switchToInterview;

@end