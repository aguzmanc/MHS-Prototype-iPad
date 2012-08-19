#import <UIKit/UIKit.h>

#import "Logic.h"

@interface InterviewController : UIViewController <InterviewDelegate>
{
    Logic * _logic;
    IBOutlet UIButton * _backTolist;
}

@property(nonatomic,retain) IBOutlet UIButton * _backTolist;

-(void)setLogic:(Logic *)logic;

// Event Handlers
-(IBAction)finishClick:(id)sender;
-(IBAction)backToListClick:(id)sender;



@end
