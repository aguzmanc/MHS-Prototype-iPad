#import <UIKit/UIKit.h>

#import "Logic.h"
#import "LoginController.h"
#import "AssignedInterviewsController.h"
#import "InitializationController.h"
#import "InterviewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate, ViewChangerDelegate>
{
    // Controllers
    LoginController * _loginController;
    InitializationController * _initializationController;
    AssignedInterviewsController * _assignedInterviewsController;
    InterviewController * _interviewController;
    
    // Logic
    Logic * _logic;
}

@property (strong, nonatomic) UIWindow *window;


@end

