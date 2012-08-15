#import <UIKit/UIKit.h>

#import "Logic.h"

@interface LoginController : UIViewController
{
    Logic * _logic;
    IBOutlet UITextField * _user;
    IBOutlet UITextField * _pass;
    IBOutlet UILabel * _error;
}

// Event Handlers
-(IBAction)loginClick:(id)sender;

// Initialization
-(id)initWithLogic:(Logic *)logic;


@end
