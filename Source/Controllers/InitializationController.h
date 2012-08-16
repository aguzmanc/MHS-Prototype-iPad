#import <UIKit/UIKit.h>

#import "Logic.h"

@interface InitializationController : UIViewController
{
    Logic * _logic;
    IBOutlet UIProgressView * _myprogressview;
    IBOutlet UILabel * _mylabel;
    
    NSInteger sizeloading;
}


// Initialization
-(id)initWithLogic:(Logic *)logic;


@end
