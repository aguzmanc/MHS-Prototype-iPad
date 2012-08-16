#import <UIKit/UIKit.h>

#import "Logic.h"

@interface InterviewController : UIViewController
{
    Logic * _logic;
}

// Initialization
-(id)initWithLogic:(Logic *)logic;


@end
