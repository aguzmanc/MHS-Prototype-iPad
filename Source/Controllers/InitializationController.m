#import "InitializationController.h"

@implementation InitializationController


#pragma mark Initialization

-(id)init
{
    self = [super initWithNibName:@"InitializationView" bundle:nil];
    if (!self) return nil;
    
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


-(void)setLogic:(Logic *)logic
{
    _logic = logic;
}

#pragma mark - Progress Delegate

-(void)setTotal:(NSNumber *)total
{
    _total = total;
    
    NSLog(@" entro al mensaje total:%i",[total intValue]);
}

-(void)setIndex:(NSNumber *)index
{    
    _myprogressview.progress = [index floatValue]/[_total floatValue];
    NSLog(@" entro al mensaje index:%i",[index intValue]);
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //aqui es donde recibe de loginview el user logeado            
    
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
