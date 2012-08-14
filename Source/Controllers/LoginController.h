#import <UIKit/UIKit.h>

#import "Logic.h"

@interface LoginController : UIViewController
{
    Logic * _logic;
}

// Event Handlers
-(IBAction)test;


// Initialization
-(id)initWithLogic:(Logic *)logic;


@end
