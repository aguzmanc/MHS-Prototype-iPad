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
    
    // init cache of images
	_userImageCache = [[NSMutableDictionary alloc] init];
    
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



-(void)obtainImageForProfileNumber:(NSString *)profileNumber
{
	// Delegates Receiver for async event
	//GetFacebookUserPhotoService * service = [[GetFacebookUserPhotoService alloc] initWithImageReceiverDelegate:self];
	
	//[service obtainImageForIdentifier:identifier];
}



-(bool)existsImageForProfileNumber:(NSString *)profileNumber
{
	return ([[_userImageCache allKeys] containsObject:profileNumber] == YES);
}



-(UIImage *)getImageForProfileNumber:(NSString *)profileNumber;
{
	return [_userImageCache objectForKey:profileNumber];
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
        NSLog(@"status no en size%@",message);        
    }
    //mandando valores de estado y mensaje de error al initializationview
}

-(void)updateProgressStatus:(int)valor
{
    NSLog(@"status no en size %@:",valor);
    //mandando valor para su actualizacion al progressview
}

@end
