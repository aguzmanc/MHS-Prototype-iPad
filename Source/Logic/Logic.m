#import "Logic.h"

@implementation Logic

@synthesize interviewList = _interviewList;

#pragma mark - Initialization

-(id)initWithViewChangerDelegate:(id<ViewChangerDelegate>)viewChanger
   andAssignedInterviewsDelegate:(id<AssignedInterviewsDelegate>)assignedInterviews
{
    self = [super init];
    
    _viewChangerDelegate = viewChanger;
    _assignedInterviewsDelegate = assignedInterviews;
    _loginUserService = [[LoginUserService alloc] initWithDelegate:self];
    _sizeUserService = [[SizeUserService alloc] initWithDelegate:self];
    
    // init cache of images
	_userImageCache = [[NSMutableDictionary alloc] init];
    _profileNumbersWaitingForPhoto = [[NSMutableArray alloc] init];
    _defaultImage = [UIImage imageNamed:@"default_photo.png"];
    
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






#pragma mark - LoginUserServiceDelegate

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
    
    [_userImageCache setObject:image forKey:profileNumber];
}



-(void)receiveImageErrorForProfileNumber:(NSString *)profileNumber
{
    [_assignedInterviewsDelegate updateImage:_defaultImage forProfileNumber:profileNumber];
    
    [_userImageCache setObject:_defaultImage forKey:profileNumber];
}

@end
