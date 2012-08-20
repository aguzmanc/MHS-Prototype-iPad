#import <UIKit/UIKit.h>

#import "Logic.h"
#import "FinishInterviewCell.h"


@interface FinishInterviewDialog : UIViewController <UITableViewDataSource, UITableViewDataSource>
{
     Logic * _logic;


}

-(IBAction)backAssignedInterviewClick:(id)sender;


// Public Methods
-(void)reloadTable;
-(void)setLogic:(Logic *)logic;



@end
