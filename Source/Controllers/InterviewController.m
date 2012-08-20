#import "InterviewController.h"

@implementation InterviewController


@synthesize _backTolist;

#pragma mark Initialization

-(id)init
{
    self = [super initWithNibName:@"InterviewController" bundle:nil];
    
    if (!self) return nil;
    return self;
}


-(void)finishClick:(id)sender
{
   
    [_logic switchToFinishInterview];

}


-(IBAction)backToListClick:(id)sender
{

    [_logic switchToAssignedInterviews];

}


#pragma mark Interview Delegate

-(void)setLogic:(Logic *)logic
{
    _logic = logic;
}


-(void)applyDataInterview:(Interview *)interview
{
    NSLog(@"applyDataInterview");
    _lblFirts_Name.text = interview.client.firstName;
    _lblLast_Name.text = interview.client.lastName;
    // format date
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"dd/MM/yyyy"];
	_lblLast_Visited.text = [format stringFromDate:interview.client.lastVisitDate];
    _lblProfile_Num.text = interview.client.profileNumber;
    _img_Photo.image =[_logic getImageForProfileNumber:interview.client.profileNumber];
    if(_img_Photo.image==NULL)
    {
        _img_Photo.image = [UIImage imageNamed:@"default_photo.png"];
    }
    NSDateFormatter * formatTime = [[NSDateFormatter alloc] init];
    [formatTime setDateFormat:@"HH:mm:ss"];

    NSDateFormatter * formatNow = [[NSDateFormatter alloc] init];
	[formatNow setDateFormat:@"dd/MM/yyyy"];
    
    _lblDate.text = [formatNow stringFromDate:[NSData data]];
    _lblStartTime.text = [formatTime stringFromDate:interview.startTime];
    _lblEndTime.text = [formatTime stringFromDate:interview.endTime];
    
    NSTimeInterval interval = [interview.startTime timeIntervalSinceDate: interview.endTime];
    int hour = interval / 3600;
    int minute = (int)interval % 3600 / 60;
    
    NSLog(@"%dHrs. %dmin.", ABS(hour), ABS(minute));
    
    _textComment.text = interview.comment;
    _lblCost.text = [NSString  stringWithFormat:@"%g" ,interview.cost];
    
   NSLog(@"%@",[NSString  stringWithFormat:@"%g" ,interview.cost]);
    
}

#pragma mark - View lifecycle

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidLoad
{
    _backTolist.transform = CGAffineTransformMakeRotation(M_PI/ -4);    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [_lblFirts_Name release];
    _lblFirts_Name = nil;
    [_lblLast_Name release];
    _lblLast_Name = nil;
    [_lblLast_Visited release];
    _lblLast_Visited = nil;
    [_lblProfile_Num release];
    _lblProfile_Num = nil;
    [_img_Photo release];
    _img_Photo = nil;
    [_lblDate release];
    _lblDate = nil;
    [_lblStartTime release];
    _lblStartTime = nil;
    [_lblEndTime release];
    _lblEndTime = nil;
    [_lblTimeSpent release];
    _lblTimeSpent = nil;
    [_textComment release];
    _textComment = nil;
    [_lblCost release];
    _lblCost = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)dealloc {
    [_lblFirts_Name release];
    [_lblLast_Name release];
    [_lblLast_Visited release];
    [_lblProfile_Num release];
    [_img_Photo release];
    [_lblDate release];
    [_lblStartTime release];
    [_lblEndTime release];
    [_lblTimeSpent release];
    [_textComment release];
    [_lblCost release];
    [super dealloc];
}
@end
