#import "InitializationController.h"

@implementation InitializationController


#pragma mark Initialization

- (id)initWithLogic:(Logic *)logic
{
    self = [super initWithNibName:@"InitializationView" bundle:nil];
    _logic = logic;
    
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
-(void)moreprogress
{
    _myprogressview.progress += 0.1 ;
   
    
    NSString *theValue = [[NSString alloc]initWithFormat:@"%.0f %%",_myprogressview.progress * 100]; 
    _mylabel.text = theValue;

}
*/


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //aqui es donde recibe de loginview el user logeado
    [_logic userService:@"interview_list" UserId:@"2"];          
    
    [super viewDidLoad];   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{    
	return YES;
}

@end
