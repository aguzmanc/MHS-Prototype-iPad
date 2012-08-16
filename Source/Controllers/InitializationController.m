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
