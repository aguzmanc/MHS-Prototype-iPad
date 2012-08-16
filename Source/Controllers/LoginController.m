#import "LoginController.h"

@implementation LoginController

#pragma mark Initialization

-(id)initWithLogic:(Logic *)logic
{
    self = [super initWithNibName:@"LoginView" bundle:nil];
    _logic = logic;
    
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark Event Handlers

-(IBAction)loginClick:(id)sender
{
    NSString * user = _user.text;
    NSString * pass = _pass.text;
    NSLog(@"%@-%@",user, pass);
    
    [_logic loginUser:user Pass:pass];    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
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
