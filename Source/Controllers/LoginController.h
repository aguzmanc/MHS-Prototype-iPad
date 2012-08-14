#import <UIKit/UIKit.h>

#import "Logic.h"

@interface LoginController : UIViewController
{
    Logic * _logic;
    UITextField *user;
    UITextField *pass;
}

@property (nonatomic, strong) IBOutlet UITextField *user;
@property (nonatomic, strong) IBOutlet UITextField *pass;


// Event Handlers
-(IBAction)test;
-(IBAction)loginClick:(id)sender;
// Initialization
-(id)initWithLogic:(Logic *)logic;


@end
