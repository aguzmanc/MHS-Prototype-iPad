#import "Logic.h"

@implementation Logic

@synthesize interviewList = _interviewList;

#pragma mark - Initialization

-(id)initWithViewChangerDelegate:(id<ViewChangerDelegate>)viewChanger
            andLoginUserDelegate:(id<LoginUserDelegate>)loginUsers
       andInitializationDelegate:(id<InitializationDelegate>)initialization
            andInterviewDelegate:(id<InterviewDelegate>)interviews
   andAssignedInterviewsDelegate:(id<AssignedInterviewsDelegate>)assignedInterviews
{
    self = [super init];
    
    _viewChangerDelegate = viewChanger;
    _assignedInterviewsDelegate = assignedInterviews;
    _loginUserDelegate = loginUsers;
    _interviewDelegate = interviews;
    _initializationDelegate = initialization;
    
    _loginUserService = [[LoginUserService alloc] initWithDelegate:self];    
    _progressService = [[ProgressService alloc] initWithDelegate:self];
           
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

-(void)switchToFinishInterview
{
    [_viewChangerDelegate switchToFinishInterview];
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


-(Interview *)getDummyInterview
{
    // dummy data
    Interview * interview = [[Interview alloc] init];
    interview.interviewId = @"k2374";
    interview.startTime = [NSDate date];
    interview.endTime = [NSDate date];
    interview.cost = 34.52;
    interview.comment = @"Lorem Ipsum";
    interview.visited = [NSDate date];
    interview.client = [[Client alloc] init];
    interview.client.middleName = @"AGC";
    interview.client.info = @"Lorem Ipsum";
    interview.client.lastVisitDate = [NSDate date];
    
    interview.visited = ((rand()%2) == 0);
    
    int clientIndex  = rand()%3;
    
    NSArray * names = [NSArray arrayWithObjects:@"Mauricio", @"Johan", @"Neil", nil];
    NSArray * lastNames = [NSArray arrayWithObjects:@"Larrea S.", @"Munchen Fr.", @"Rodemberg", nil];
    NSArray * profiles = [NSArray arrayWithObjects:@"UF-927-X", @"WS-221-C", @"IT-521-Q", nil];
    NSArray * photos = [NSArray arrayWithObjects:@"photo1.jpg", @"photo2xdfasdfasd.jpg", @"photo3.jpg", nil];
    
    interview.client.firstName = [names objectAtIndex:clientIndex];
    interview.client.lastName = [lastNames objectAtIndex:clientIndex];
    interview.client.profileNumber = [profiles objectAtIndex:clientIndex];
    interview.client.photoFileName = [photos objectAtIndex:clientIndex];
    
    return interview;
}



-(void)makeInterview:(Interview *)interview
{
    _selectedInterview = interview;
    [self switchToInterview];
    [_interviewDelegate applyDataInterview:_selectedInterview];
    }


#pragma mark - ProgressServiceDelegate

-(void)indexService:(NSNumber *)indexvalor
{
   NSLog(@"entro al servici delagate");
   [_initializationDelegate setIndex:indexvalor];
}



#pragma mark - LoginUserServiceDelegate

-(void)loginStatus:(BOOL)status AndMessage:(NSString *)message
{
	if (status == YES) 
	{		        
        NSLog(@" Entro con YES: con id usuario");
        
        [self switchToInitialization];
        [_progressService initProgress:@"1"];
	}
	else
    {
        NSLog(@" estusu no");
        [_loginUserDelegate loginError:message];
    }    
}

-(void)errorLoginService:(NSString *)message
{
    [_loginUserDelegate errorLogin:message];

}



#pragma mark - AsyncProfileImageReceiverDelegate

-(void)receiveImage:(UIImage *)image ForProfileNumber:(NSString *) profileNumber
{
    [_assignedInterviewsDelegate updateImage:image forProfileNumber:profileNumber];
    
    [_userImageCache setObject:image forKey:profileNumber];
}



-(void)receiveImageErrorForProfileNumber:(NSString *)profileNumber
{
    [_assignedInterviewsDelegate updateImage:_defaultImage forProfileNumber:profileNumber];
}
@end
