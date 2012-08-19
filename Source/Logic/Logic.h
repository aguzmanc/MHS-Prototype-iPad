#import <Foundation/Foundation.h>

#import "LoginUserService.h"
#import "ProgressService.h"
#import "PhotoService.h"
#import "Client.h"
#import "Interview.h"

@protocol ViewChangerDelegate;
@protocol AssignedInterviewsDelegate;
@protocol LoginUserDelegate;
@protocol InitializationDelegate;
@protocol InterviewDelegate;

@interface Logic : NSObject <LoginUserServiceDelegate, AsyncProfileImageReceiverDelegate, ProgressServiceDelegate>
{
    // delegates
    id<ViewChangerDelegate> _viewChangerDelegate;
    id<LoginUserDelegate> _loginUserDelegate;
    id<InitializationDelegate> _initializationDelegate;
    id<InterviewDelegate> _interviewDelegate;
    id<AssignedInterviewsDelegate> _assignedInterviewsDelegate;
    
    // Services
    LoginUserService * _loginUserService;
    ProgressService * _progressService;
    
    // Logic data 
    NSArray * _interviewList;
    NSMutableDictionary * _userImageCache;
    NSMutableArray * _profileNumbersWaitingForPhoto;
    UIImage * _defaultImage;
    
    Interview * _selectedInterview;
}

// Properties

@property (strong, nonatomic) NSArray * interviewList;

// Initialization
-(id)initWithViewChangerDelegate:(id<ViewChangerDelegate>)viewChanger
            andLoginUserDelegate:(id<LoginUserDelegate>)loginUsers
       andInitializationDelegate:(id<InitializationDelegate>)initialization
            andInterviewDelegate:(id<InterviewDelegate>)interviews
   andAssignedInterviewsDelegate:(id<AssignedInterviewsDelegate>)assignedInterviews;

// Public Methods
-(void)switchToInitialization;
-(void)switchToLogin;
-(void)switchToAssignedInterviews;
-(void)switchToInterview;
-(void)switchToFinishInterview;


-(bool)existsImageForProfileNumber:(NSString *)profileNumber;
-(UIImage *)getImageForProfileNumber:(NSString *)profileNumber;
-(void)obtainImageForProfileNumber:(NSString *)profileNumber withFileName:(NSString *)fileName;

-(void)loginUser:(NSString *)user Pass:(NSString *)pass;

-(Interview *)getDummyInterview;

-(void)makeInterview:(Interview *)interview;

@end








/*
 *  VIEW CHANGER DELEGATE
 */

@protocol ViewChangerDelegate

-(void)switchToInitialization;
-(void)switchToAssignedInterviews;
-(void)switchToLogin;
-(void)switchToInterview;
-(void)switchToFinishInterview;


@end



/*
 *  Interview DELEGATE
 */
@protocol InterviewDelegate

-(void)setLogic:(Logic *)logic;

@end



/*
 *  Initializations DELEGATE
 */
@protocol InitializationDelegate

-(void)setLogic:(Logic *)logic;
-(void)setIndex:(NSNumber *)index;
//-(void)updateProgressDelegate:(NSNumber *)indexProg TotalSize:(NSNumber *)totalSize;
@end



/*
 *  LOGIN DELEGATE
 */
@protocol LoginUserDelegate

-(void)setLogic:(Logic *)logic;
-(void)loginError:(NSString *)message;
-(void)errorLogin:(NSString *)message;

@end


/*
 *  ASSIGNED INTERVIEWS DELEGATE
 */
@protocol AssignedInterviewsDelegate

-(void)updateImage:(UIImage *)image forProfileNumber:(NSString *)profileNumber;

@end