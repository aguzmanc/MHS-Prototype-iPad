#import "AssignedInterviewsController.h"

@implementation AssignedInterviewsController


@synthesize tableData;

#pragma mark - Initialization

- (id)init
{
    self = [super initWithNibName:@"AssignedInterviewsView" bundle:nil];
    
    if (!self) return nil;
    
    _imagesButtonsOn = [[NSMutableArray alloc] initWithObjects:
                        [UIImage imageNamed:@"all_selected.png"],
                        [UIImage imageNamed:@"mon_selected.png"],
                        [UIImage imageNamed:@"tue_selected.png"],
                        [UIImage imageNamed:@"wed_selected.png"],
                        [UIImage imageNamed:@"thu_selected.png"],
                        [UIImage imageNamed:@"fri_selected.png"],
                        [UIImage imageNamed:@"sat_selected.png"],
                        [UIImage imageNamed:@"sun_selected.png"],
                        nil];
    
    _imagesButtonsOff = [[NSMutableArray alloc] initWithObjects:
                         [UIImage imageNamed:@"all_unselected.png"],
                         [UIImage imageNamed:@"mon_unselected.png"],
                         [UIImage imageNamed:@"tue_unselected.png"],
                         [UIImage imageNamed:@"wed_unselected.png"],
                         [UIImage imageNamed:@"thu_unselected.png"],
                         [UIImage imageNamed:@"fri_unselected.png"],
                         [UIImage imageNamed:@"sat_unselected.png"],
                         [UIImage imageNamed:@"sun_unselected.png"],
                         nil];
    
     _waitingCells = [[NSMutableArray alloc] init];
        
    return self;
}







#pragma mark - Public Methods

-(void)reloadTable
{
}

-(void)setLogic:(Logic *)logic
{
    _logic = logic;
}




-(void)setDayButton:(int)index
{
    if (index > 7 || index < 0) return;
    
    // first deselect all
    [_btnAll setImage:[_imagesButtonsOff objectAtIndex:0] forState:UIControlStateNormal];
    [_btnMon setImage:[_imagesButtonsOff objectAtIndex:1] forState:UIControlStateNormal];
    [_btnTue setImage:[_imagesButtonsOff objectAtIndex:2] forState:UIControlStateNormal];
    [_btnWed setImage:[_imagesButtonsOff objectAtIndex:3] forState:UIControlStateNormal];
    [_btnThu setImage:[_imagesButtonsOff objectAtIndex:4] forState:UIControlStateNormal];
    [_btnFri setImage:[_imagesButtonsOff objectAtIndex:5] forState:UIControlStateNormal];
    [_btnSat setImage:[_imagesButtonsOff objectAtIndex:6] forState:UIControlStateNormal];
    [_btnSun setImage:[_imagesButtonsOff objectAtIndex:7] forState:UIControlStateNormal];
    
    
    // now override image with selected index
    switch (index) {
        case 0: [_btnAll setImage:[_imagesButtonsOn objectAtIndex:index] forState:UIControlStateNormal]; break; 
        case 1: [_btnMon setImage:[_imagesButtonsOn objectAtIndex:index] forState:UIControlStateNormal]; break;
        case 2: [_btnTue setImage:[_imagesButtonsOn objectAtIndex:index] forState:UIControlStateNormal]; break;
        case 3: [_btnWed setImage:[_imagesButtonsOn objectAtIndex:index] forState:UIControlStateNormal]; break;
        case 4: [_btnThu setImage:[_imagesButtonsOn objectAtIndex:index] forState:UIControlStateNormal]; break;
        case 5: [_btnFri setImage:[_imagesButtonsOn objectAtIndex:index] forState:UIControlStateNormal]; break;
        case 6: [_btnSat setImage:[_imagesButtonsOn objectAtIndex:index] forState:UIControlStateNormal]; break;
        case 7: [_btnSun setImage:[_imagesButtonsOn objectAtIndex:index] forState:UIControlStateNormal]; break;
    }
}






#pragma mark - Action Handlers

-(IBAction)monClick
{ 
    [self setDayButton:1];
}



-(IBAction)tueClick
{ 
    [self setDayButton:2];
}



-(IBAction)wedClick
{ 
    [self setDayButton:3];
}



-(IBAction)thuClick
{ 
    [self setDayButton:4];
}



-(IBAction)friClick
{ 
    [self setDayButton:5];
}



-(IBAction)satClick
{ 
    [self setDayButton:6];
}



-(IBAction)sunClick
{ 
    [self setDayButton:7];
}



-(IBAction)allClick
{ 
    [self setDayButton:0];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setDayButton:0]; // default
}






#pragma mark - Assigned Interviews Delegate

-(void)updateImage:(UIImage *)image forProfileNumber:(NSString *)profileNumber
{
    for (InterviewCell * cell in _waitingCells) {
        if([cell.interview.client.profileNumber isEqualToString:profileNumber])
           [cell setImage:image];
    }
}






#pragma mark - TableView Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return 20;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 	
	InterviewCell * cell = (InterviewCell *)[tableView dequeueReusableCellWithIdentifier:@"InterviewCell"];
	
    if (cell == nil) {
		NSArray * objs = [[NSBundle mainBundle] loadNibNamed:@"InterviewCell" owner:nil options:nil];
		
		for (id obj in objs) {
			if ([obj isKindOfClass:[InterviewCell class]]) {
				cell = (InterviewCell *)obj;
                                
				break;
			}
		}
	}

    // recycled cells, should not be in the state of 'waiting'
    [_waitingCells removeObjectIdenticalTo:cell];
    
	// link cell with according identifier
	//Interview * interview = [_logic getDesireForIndex:indexPath.row];
    
    // dummy data
    Interview * interview = [[Interview alloc] init];
    interview.interviewId = @"k2374";
    interview.startTime = [NSDate date];
    interview.endTime = [NSDate date];
    interview.cost = 34.52;
    interview.comment = @"Lorem Ipsum";
    interview.visited = [NSDate date];
    interview.client = [[Client alloc] init];
    interview.client.profileNumber = @"009-XXX";
    interview.client.firstName = @"Mauricio";
    interview.client.lastName = @"Larrea S.";
    interview.client.middleName = @"AGC";
    interview.client.info = @"Lorem Ipsum";
    interview.client.lastVisitDate = [NSDate date];
	
	// Apply data to Interview Cell View
	[cell applyData:interview];
	// Assign logic to cell
	cell.logic = _logic;
    
    NSString * profileNumber = interview.client.profileNumber;
    
	// check if there is user image in the cache
	if ([_logic existsImageForProfileNumber:profileNumber] == YES) { 
		[cell setImage:[_logic getImageForProfileNumber:profileNumber]];
	}
	else {
        [_waitingCells addObject:cell];
		[cell waitForPhoto];
        [_logic obtainImageForProfileNumber:profileNumber withFileName:interview.client.photoFileName];
	}
	
	return cell;	
}


#pragma mark - Table View delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 133; // --- set height for rows of custom table view
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1; //--- set default 1 number of section because only had one section's
}





- (void)didReceiveMemoryWarning
{    
    [super didReceiveMemoryWarning];    
}






#pragma mark - View lifecycle



- (void)viewDidUnload
{
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{    
	return YES;
}



@end
