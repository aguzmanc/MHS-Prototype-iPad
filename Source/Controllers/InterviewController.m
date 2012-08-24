#import "InterviewController.h"
#import "MessageDialogView.h"

@implementation InterviewController


@synthesize _backTolist;


MessageDialogView *messageDialogView;

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
    messageDialogView = [[MessageDialogView alloc] initWithNibName:@"MessageDialogController" bundle:nil];
    
    [messageDialogView setLogic:_logic];
    
    [self.view.superview addSubview:messageDialogView.view];
    
}
-(void)interviewMessageSave
{
    _end_Time = [NSDate date];
    NSDateFormatter * formatDate = [[NSDateFormatter alloc] init];
    [formatDate setDateFormat:@"HH:mm:ss"];
    [_lblEndTime setText:[formatDate stringFromDate:_end_Time]];
    NSTimeInterval interval = [_start_Time timeIntervalSinceDate: _end_Time];
    int hour = interval / 3600;
    int minute = (int)interval % 3600 /60;
    
    hour = ABS(hour);
    minute = ABS(minute);
    
    [_lblTimeSpent setText:[NSString stringWithFormat:@"%d:%d", hour, minute]];         
    
    [formatDate setDateFormat:@"HH:mm:ss"];    
    [_logic interviewSaveService:_interview_id
                     andStarTime:_start_Time
                      andEndTime:_end_Time
                    andTimespent:[formatDate dateFromString:_lblTimeSpent.text] 
                      andComment:_textComment.text 
                         andCost:_lblCost.text];
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
        int minute = (int)interval % 3600 /60;
        
        hour = ABS(hour);
        minute = ABS(minute);
        
        [_lblTimeSpent setText:[NSString stringWithFormat:@"%d:%d", hour, minute]];         
       
        [formatDate setDateFormat:@"HH:mm:ss"];    
        [_logic interviewSaveService:_interview_id
                         andStarTime:_start_Time
                          andEndTime:_end_Time
                        andTimespent:[formatDate dateFromString:_lblTimeSpent.text] 
                          andComment:_textComment.text 
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
    const int movementDistance = 250; // lo que sea necesario, en mi caso yo use 80
    const float movementDuration = 0.3f; // lo que sea necesario
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


-(void)textViewDidBeginEditing:(UITextView *)textView
{
 [self slideFrame:YES];

}

-(void)textViewDidEndEditing:(UITextView *)textView
{
[self slideFrame:NO];
    NSLog(@"entra");
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
    [formatStart setDateFormat:@"HH:mm a"];
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
    
    [formatDate setDateFormat:@"HH:mm a"];
    _lblStartTime.text = [formatDate stringFromDate:interview.startTime];
    _lblEndTime.text = [formatDate stringFromDate:interview.endTime];
    _textComment.text = interview.comment;
    [formatDate setDateFormat:@"HH:mm"];    
    _lblTimeSpent.text = [formatDate stringFromDate:interview.interviewTime];
    _textComment.userInteractionEnabled = FALSE;
    _lblCost.userInteractionEnabled = FALSE;
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_lblCost  resignFirstResponder];
    [_textComment resignFirstResponder];
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
     [messageDialogView release];
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
