#import "InitializationController.h"

@implementation InitializationController


#pragma mark Initialization

-(id)init
{
    self = [super initWithNibName:@"InitializationView" bundle:nil];
    if (!self) return nil;
    
    return self;
}


-(void)setLogic:(Logic *)logic
{
    _logic = logic;
}

#pragma mark - Progress Delegate

-(void)progressbar
{
    _myprogressview.progress += 0.3; 
    if(_myprogressview.progress==1)
    {
        [timer invalidate];
        [_logic switchToAssignedInterviews]; 
    }
}

-(void)setIndex:(NSNumber *)index
{           
    
    NSLog(@" proceso de index:%i",[index intValue]);
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //aqui es donde recibe de loginview el user logeado            
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(progressbar) userInfo:nil repeats:YES];//dummy
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
