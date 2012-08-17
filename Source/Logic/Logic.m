#import "Logic.h"

@implementation Logic

@synthesize interviewList = _interviewList;

#pragma mark - Initialization

-(id)initWithViewChangerDelegate:(id<ViewChangerDelegate>)viewChanger
            andLoginUserDelegate:(id<LoginUserDelegate>)loginUsers
   andAssignedInterviewsDelegate:(id<AssignedInterviewsDelegate>)assignedInterviews
{
    self = [super init];
    
    _viewChangerDelegate = viewChanger;
    _assignedInterviewsDelegate = assignedInterviews;
    _loginUserDelegate = loginUsers;
    
    _loginUserService = [[LoginUserService alloc] initWithDelegate:self];
    _sizeUserService = [[SizeUserService alloc] initWithDelegate:self];
    
    
    [_loginUserDelegate setLogic:self];
    
    // init cache of images
	_userImageCache = [[NSMutableDictionary alloc] init];
    _profileNumbersWaitingForPhoto = [[NSMutableArray alloc] init];
    _defaultImage = [UIImage imageNamed:@"default_photo.png"];
    
    return self;
}



-(void)loginUser:(NSString *)user Pass:(NSString *)pass
{
    NSLog(@"Entramos a la logica para pasarle al servicio");
    [_loginUserService loginUser:user Pass:pass];
}



-(void)userService:(NSString *)service UserId:(NSString *)userid
{
    NSLog(@"entro a size ");
    [_sizeUserService userService:service UserId:userid];
}





#pragma mark - Public Methods

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



-(void)obtainImageForProfileNumber:(NSString *)profileNumber withFileName:(NSString *)fileName;
{
    if([_profileNumbersWaitingForPhoto containsObject:profileNumber])
        return ;  // another process already require the same profile number, so it is innecesary require it again
    
    [_profileNumbersWaitingForPhoto addObject:profileNumber]; // put in the waiting list
    PhotoService * service = [[PhotoService alloc] initWithProfileImageReceiverDelegate:self andProfileNumber:profileNumber];
    
    [service obtainImageForFile:fileName];
}



-(bool)existsImageForProfileNumber:(NSString *)profileNumber
{
	return ([[_userImageCache allKeys] containsObject:profileNumber] == YES);
}



-(UIImage *)getImageForProfileNumber:(NSString *)profileNumber;
{
	return [_userImageCache objectForKey:profileNumber];
}






#pragma mark - LoginUserServiceDelegate

-(void)loginStatus:(BOOL)status AndMessage:(NSString *)message
{
	if (status == YES) 
	{
		        
        NSLog(@" Entro con YES: con id usuario");
        [_viewChangerDelegate switchToInitialization];
	}
	else
    {
        NSLog(@" estusu no");
        [_loginUserDelegate loginError:message];
    }    
}

#pragma mark - SizeUserServiceDelegate

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


#pragma mark - AsyncProfileImageReceiverDelegate

-(void)receiveImage:(UIImage *)image ForProfileNumber:(NSString *) profileNumber
{
    [_assignedInterviewsDelegate updateImage:image forProfileNumber:profileNumber];
}



-(void)receiveImageErrorForProfileNumber:(NSString *)profileNumber
{
    [_assignedInterviewsDelegate updateImage:_defaultImage forProfileNumber:profileNumber];
}

@end
