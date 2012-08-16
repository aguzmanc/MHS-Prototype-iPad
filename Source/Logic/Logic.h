/*
  modifique algo de la vista loading */

#import <Foundation/Foundation.h>

#import "LoginUserService.h"

@protocol ViewChangerDelegate;


@interface Logic : NSObject <LoginUserServiceDelegate>
{
    // delegates
    id<ViewChangerDelegate> _viewChangerDelegate;
    
    
    LoginUserService * _loginUserService;
}

// Properties

// Initialization
-(id)initWithViewChangerDelegate:(id<ViewChangerDelegate>)viewChanger;

// Public Methods
-(void)switchToInitialization;
-(void)switchToLogin;
-(void)switchToAssignedInterviews;
-(void)switchToInterview;

-(void)loginUser:(NSString *)user Pass:(NSString *)pass;

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