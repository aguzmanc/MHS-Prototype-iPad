#import "AssignedInterviewsController.h"

@implementation AssignedInterviewsController


@synthesize tableData;

#pragma mark Initialization

- (id)initWithLogic:(Logic *)logic
{
    self = [super initWithNibName:@"AssignedInterviewsView" bundle:nil];
    _logic = logic;
    
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark Public Methods

-(void)reloadTable
{
}


#pragma mark - TableView Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    return cell;
    
}



- (void)didReceiveMemoryWarning
{    
    [super didReceiveMemoryWarning];    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    tableData = [[ NSArray alloc] initWithObjects:@"", @"", @"", @"", @"", nil];
            
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{    
	return YES;
}



@end
