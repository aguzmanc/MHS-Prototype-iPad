#import "LoginController.h"

@implementation LoginController

#pragma mark Initialization

-(id)init
{
    self = [super initWithNibName:@"LoginView" bundle:nil];
        
    if (!self) return nil;

    return self;
}


-(void)setLogic:(Logic *)logic
{
    _logic = logic;
}

#pragma mark Event Handlers

-(IBAction)loginClick:(id)sender
{
    NSString * user = _user.text;
    NSString * pass = _pass.text;
    NSLog(@"Hacemos click en login: %@-%@",user, pass);    
    [_logic loginUser:user Pass:pass];    
    
}

#pragma mark - Login Users Delegate

-(void)loginError:(NSString *)message
{
    NSLog(@"entro con  el mensaje Error:%@", message);
    _error.hidden = FALSE;    
}

-(void)errorLogin:(NSString *)message
{
    NSLog(@"Error de conexion:%@", message);
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
