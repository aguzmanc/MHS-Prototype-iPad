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
        [_logic interviewSaveService:_interview_id
                         andStarTime:_lblStartTime.text 
                          andEndTime:_lblEndTime.text
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
    const int movementDistance = 300; // lo que sea necesario, en mi caso yo use 80
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
    
}

-(void)applyDataInterview:(Interview *)interview
{
    NSLog(@"applyDataInterview");
    _lblDate.enabled = NO;
    
    _lblFirts_Name.text = interview.client.firstName;
    _lblLast_Name.text = interview.client.lastName;
    _lblProfile_Num.text = interview.client.profileNumber;
    _img_Photo.image =[_logic getImageForProfileNumber:interview.client.profileNumber];
    
    if(_img_Photo.image == nil)
    {
        _img_Photo.image = [UIImage imageNamed:@"default_photo.png"];
    }
    
    // format date
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"dd/MM/yyyy"];

    [_lblDate setText:[format stringFromDate:interview.scheduleDate]];

    if(interview.startTime == nil)
    {
        interview.startTime = [NSDate date]; // now!
    }
    
    [format setDateFormat:@"hh:mm a"];
    [_lblStartTime setText:[format stringFromDate:interview.startTime]];
    
    if(interview.endTime != nil)
    {
        [_lblEndTime setText:[format stringFromDate:interview.endTime]];
        
        NSTimeInterval interval = [interview.startTime timeIntervalSinceDate: interview.endTime];
        int hour = interval / 3600;
        
        hour = ABS(hour);
        
        [_lblTimeSpent setText:[NSString stringWithFormat:@"%d", hour]];
    }    
    
    _textComment.text = interview.comment;
    _lblCost.text = [NSString  stringWithFormat:@"%d" ,interview.cost];
    
    _btnFinish.hidden = interview.visited;
    _textComment.userInteractionEnabled = (interview.visited == NO);
    _lblCost.userInteractionEnabled = (interview.visited == NO);
    
    //NSLog(@"%@",[NSString  stringWithFormat:@"%g" ,interview.cost]);
}






#pragma mark - Interview Save Delegate

-(void)successInterviewSave:(BOOL)status andMessage:(NSString *)message;
{
    [_logic switchToAssignedInterviews];
}



-(void)errorInterviewSaveService:(NSString *)message;
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
    [_lblCost release];
    _lblCost = nil;
    [_lblTimeSpent release];
    _lblTimeSpent = nil;
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
    [_lblLast_Visited release];
    [_lblProfile_Num release];
    [_img_Photo release];
     [_lblDate release];
    [_lblStartTime release];
    [_lblEndTime release];
    
    [_lblCost release];
    [_lblTimeSpent release];
    [super dealloc];
}
@end
