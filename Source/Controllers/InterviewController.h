#import <UIKit/UIKit.h>

#import "Logic.h"

@interface InterviewController : UIViewController <InterviewDelegate>
{
    Logic * _logic;
    IBOutlet UIButton * _backTolist;
    
    IBOutlet UILabel *_lblFirts_Name;
    IBOutlet UILabel *_lblLast_Name;
    IBOutlet UILabel *_lblLast_Visited; 
    IBOutlet UILabel *_lblProfile_Num;
    
    IBOutlet UIImageView *_img_Photo;
    
    NSString *_client_profile_id;
    
    IBOutlet UILabel *_lblDate;
    IBOutlet UILabel *_lblStartTime;
    IBOutlet UILabel *_lblEndTime;
    IBOutlet UILabel *_lblTimeSpent;
    IBOutlet UITextView *_textComment;
    IBOutlet UILabel *_lblCost;
}

@property(nonatomic,retain) IBOutlet UIButton * _backTolist;

-(void)setLogic:(Logic *)logic;

// Event Handlers
-(IBAction)finishClick:(id)sender;
-(IBAction)backToListClick:(id)sender;



@end
