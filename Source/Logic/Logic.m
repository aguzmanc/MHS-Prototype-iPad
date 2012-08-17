#import "Logic.h"

@implementation Logic

@synthesize interviewList = _interviewList;


#pragma mark Initialization

-(id)initWithViewChangerDelegate:(id<ViewChangerDelegate>)viewChanger
{
    self = [super init];
    
    _viewChangerDelegate = viewChanger;
    _loginUserService = [[LoginUserService alloc] initWithDelegate:self];
    _sizeUserService = [[SizeUserService alloc] initWithDelegate:self];
    
    return self;
}



-(void)loginUser:(NSString *)user Pass:(NSString *)pass
{
    NSLog(@"entro a loginc isloginuser");
    [_loginUserService loginUser:user Pass:pass];
}



-(void)userService:(NSString *)service UserId:(NSString *)userid
{
    NSLog(@"entro a size ");
    [_sizeUserService userService:service UserId:userid];
}





#pragma mark Public Methods

-(void)switchToInitialization
{
    [_viewChangerDelegate switchToInitialization];
}



-(void)switchToLogin
{
    [_viewChangerDelegate switchToLogin];
}



-(void)switchToAssignedInterviews
{
    [_viewChangerDelegate switchToAssignedInterviews];
}



-(void)switchToInterview
{
    [_viewChangerDelegate switchToInterview];
}


#pragma mark LoginUserServiceDelegate

-(void)loginStatus:(BOOL)status AndMessage:(NSString *)message
{
	if (status == YES) 
	{
		NSLog(@" estusu yes");
        [_viewChangerDelegate switchToInitialization];
	}
	else
    {
        NSLog(@" estusu no");        
    }    
}



#pragma mark SizeUserServiceDelegate
-(void)sizeStatus:(BOOL)status AndMessage:(NSString *)message
{
	if (status == YES) 
	{
		NSLog(@"status yes en size%@",message);
	}
	else
    {
        NSLog(@"status no en size");        
    }    
}

-(void)updateStatus:(float)valor
{
    NSLog(@"status no en size %@:",valor);

}

@end
