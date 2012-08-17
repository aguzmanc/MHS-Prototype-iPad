#import <Foundation/Foundation.h>

#import "LoginUserService.h"
#import "SizeUserService.h"
#import "PhotoService.h"
#import "Client.h"
#import "Interview.h"

@protocol ViewChangerDelegate;
@protocol AssignedInterviewsDelegate;


@interface Logic : NSObject <LoginUserServiceDelegate, SizeUserServiceDelegate, AsyncProfileImageReceiverDelegate>
{
    // delegates
    id<ViewChangerDelegate> _viewChangerDelegate;
    id<AssignedInterviewsDelegate> _assignedInterviewsDelegate;
    
    // Services
    LoginUserService * _loginUserService;
    SizeUserService  * _sizeUserService;
    
    // Logic data 
    NSArray * _interviewList;
    NSMutableDictionary * _userImageCache;
    NSMutableArray * _profileNumbersWaitingForPhoto;
    UIImage * _defaultImage;
}

// Properties

@property (strong, nonatomic) NSArray * interviewList;

// Initialization
-(id)initWithViewChangerDelegate:(id<ViewChangerDelegate>)viewChanger
   andAssignedInterviewsDelegate:(id<AssignedInterviewsDelegate>)assignedInterviews;

// Public Methods
-(void)switchToInitialization;
-(void)switchToLogin;
-(void)switchToAssignedInterviews;
-(void)switchToInterview;


-(bool)existsImageForProfileNumber:(NSString *)profileNumber;
-(UIImage *)getImageForProfileNumber:(NSString *)profileNumber;
-(void)obtainImageForProfileNumber:(NSString *)profileNumber withFileName:(NSString *)fileName;

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



/*
 *  ASSIGNED INTERVIEWS DELEGATE
 */
@protocol AssignedInterviewsDelegate

-(void)updateImage:(UIImage *)image forProfileNumber:(NSString *)profileNumber;

@end