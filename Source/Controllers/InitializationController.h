#import <UIKit/UIKit.h>

#import "Logic.h"

@interface InitializationController : UIViewController
{
    Logic * _logic;
}

// Initialization
-(id)initWithLogic:(Logic *)logic;


@end
