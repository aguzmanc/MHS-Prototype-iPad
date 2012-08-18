#import <UIKit/UIKit.h>

#import "Logic.h"

@interface InitializationController : UIViewController <InitializationDelegate>
{
    Logic * _logic;
    IBOutlet UIProgressView * _myprogressview;
    IBOutlet UILabel * _mylabel;
    NSNumber * _index;
    NSNumber * _total;     
}

//public method
-(void)setLogic:(Logic *)logic;


@end
