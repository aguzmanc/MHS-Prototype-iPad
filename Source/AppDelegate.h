#import <UIKit/UIKit.h>

@class LoginController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    LoginController * _loginController;
}

@property (strong, nonatomic) UIWindow *window;

@end