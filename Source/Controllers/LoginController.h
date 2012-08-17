#import <UIKit/UIKit.h>

#import "Logic.h"

@interface LoginController : UIViewController <LoginUserDelegate>
{
    Logic * _logic;
    
    IBOutlet UITextField * _user;
    IBOutlet UITextField * _pass;
    IBOutlet UILabel * _error;
}

//public method
-(void)setLogic:(Logic *)logic;

// Event Handlers
-(IBAction)loginClick:(id)sender;


@end
