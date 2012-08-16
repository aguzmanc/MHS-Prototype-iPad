#import <UIKit/UIKit.h>

#import "Logic.h"

@interface AssignedInterviewsController : UIViewController <
    UITableViewDataSource>
{
    Logic * _logic;
    
    NSArray *tableData;
}


@property (nonatomic, assign) NSArray *tableData;

// Initialization
-(id)initWithLogic:(Logic *)logic;



@end
