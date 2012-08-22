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


-(void)interviewSaveStatus
{
    [_logic switchToAssignedInterviews];
}


-(void)finishClick:(id)sender
{
    UIAlertView *messages = [[UIAlertView alloc] initWithTitle:@"SAVE INTERVIEW"
                                                       message:@"Are you sure to finish the interview"
                                                      delegate:self
                                             cancelButtonTitle:@"No"
                                             otherButtonTitles:@"Yes", nil];
    [messages show];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Yes"])
    {
         
        _end_Time = [NSDate date];
        NSDateFormatter * formatDate = [[NSDateFormatter alloc] init];
        [formatDate setDateFormat:@"HH:mm:ss"];
        [_lblEndTime setText:[formatDate stringFromDate:_end_Time]];
         NSTimeInterval interval = [_start_Time timeIntervalSinceDate: _end_Time];
         int hour = interval / 3600;
         hour = ABS(hour);
        
        NSLog(@"startime:%@",[_start_Time description]);
        NSLog(@"endtime:%@",[_end_Time description]);
        
        [_lblTimeSpent setText:[NSString stringWithFormat:@"%d", hour]];         
        NSDateFormatter * format_start = [[NSDateFormatter alloc] init];
        NSDateFormatter * format_end = [[NSDateFormatter alloc] init];
        [format_start setDateFormat:@"hhmm"];
        [format_end setDateFormat:@"hhmm"];
        
        [_logic interviewSaveService:_interview_id
                         andStarTime:[format_start stringFromDate:_start_Time]
                          andEndTime:[format_end stringFromDate:_end_Time]
                        andTimespent:_lblTimeSpent.text 
                          andCommint:_textComment.text 
                             andCost:_lblCost.text];
    }
}


-(IBAction)backToListClick:(id)sender
{

    [_logic switchToAssignedInterviews];

}


-(IBAction) slideFrameUp
{
    [self slideFrame:YES];
}

-(IBAction) slideFrameDown
{
    [self slideFrame:NO];
}

-(void) slideFrame:(BOOL)up
{
    const int movementDistance = 280; // lo que sea necesario, en mi caso yo use 80
    const float movementDuration = 0.3f; // lo que sea necesario
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


#pragma mark Interview Delegate

-(void)setLogic:(Logic *)logic
{
    _logic = logic;
}

-(void)applyDataInterviewSave:(Interview *)interview
{
     
    _interview_id = interview.interviewId;
     interview.startTime = [NSDate date];
    _start_Time = interview.startTime;
    
    // Banner principal    
    _lblFirts_Name.text = interview.client.firstName;
    _lblLast_Name.text = interview.client.lastName;
    _lblProfile_Num.text = interview.client.profileNumber;
    _img_Photo.image =[_logic getImageForProfileNumber:interview.client.profileNumber];
    _lblSuburb.text = interview.client.subUrb;
    //_lblAge.text = interview.client.age;
    if(_img_Photo.image == nil)
    {
        _img_Photo.image = [UIImage imageNamed:@"default_photo.png"];
    }
    
    _lblCost.background = [UIImage imageNamed:@"text-bg.png" ];
    NSDateFormatter * formatDate = [[[NSDateFormatter alloc] init] autorelease];
    [formatDate setDateFormat:@"yyyy-MM-dd"];    
    _lblDate.text = [formatDate stringFromDate:interview.date];
    NSDateFormatter * formatStart = [[[NSDateFormatter alloc] init] autorelease];
    [formatStart setDateFormat:@"HH:mm:ss"];
    _lblStartTime.text = [formatStart stringFromDate:interview.startTime];
    _lblEndTime.text = @"";
    _lblTimeSpent.text = @"";
    _lblCost.text = @"";
    _textComment.text = @"";
    _textComment.userInteractionEnabled = TRUE;
    _lblCost.userInteractionEnabled = TRUE;
    _btnFinish.hidden = FALSE;
    
}

-(void)applyDataInterviewView:(Interview *)interview
{
    NSLog(@"applyDataInterviewView");
    
    // Banner principal    
    _lblFirts_Name.text = interview.client.firstName;
    _lblLast_Name.text = interview.client.lastName;
    _lblProfile_Num.text = interview.client.profileNumber;
    _img_Photo.image =[_logic getImageForProfileNumber:interview.client.profileNumber];
    _lblSuburb.text = interview.client.subUrb;
    //_lblAge.text = interview.client.age;
    if(_img_Photo.image == nil)
    {
        _img_Photo.image = [UIImage imageNamed:@"default_photo.png"];
    }
    
    //Interview Details
    NSDateFormatter * formatDate = [[NSDateFormatter alloc] init];
	[formatDate setDateFormat:@"E MMM yy"];
    [_lblDate setText:[formatDate stringFromDate:interview.date]];
    
    [formatDate setDateFormat:@"hh:mm a"];
    _lblStartTime.text = [formatDate stringFromDate:interview.startTime];
    _lblEndTime.text = [formatDate stringFromDate:interview.endTime];
    _textComment.text = interview.comment;
    _lblTimeSpent.text = interview.interviewTime;
    _textComment.userInteractionEnabled = TRUE;
    _lblCost.userInteractionEnabled = TRUE;
    _lblCost.text = [NSString  stringWithFormat:@"%g" ,interview.cost];
    _btnFinish.hidden = TRUE;
}


-(void)successSaveInterview:(BOOL)status andMessage:(NSString *)message
{
   

}
-(void)errorSaveInterview:(NSString *)message;
{
    UIAlertView *messages = [[UIAlertView alloc] initWithTitle:@"ERROR CONNECTION"
                                                       message:message
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
    [messages show];

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
    [_lblSuburb release];
    _lblSuburb = nil;
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
    [_lblCost release];
    _lblCost = nil;
    [_lblTimeSpent release];
    _lblTimeSpent = nil;
    [_lblAge release];
    _lblAge = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return UIInterfaceOrientationIsPortrait(orientation);
}



- (void)dealloc {
    
    [_lblFirts_Name release];
    [_lblLast_Name release];
    [_lblSuburb release];
    [_lblProfile_Num release];
    [_img_Photo release];
     [_lblDate release];
    [_lblStartTime release];
    [_lblEndTime release];
    
    [_lblCost release];
    [_lblTimeSpent release];
    [_lblAge release];
    [super dealloc];
}
@end
