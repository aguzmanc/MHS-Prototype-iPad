#import "InterviewCell.h"

@implementation InterviewCell

@synthesize logic = _logic;


#pragma Mark - Public Methods

-(void)setImage:(UIImage *)img
{
    _imgClient.image = img;
    
	[_indicator stopAnimating];
}



-(void)waitForPhoto
{
	[_indicator startAnimating];
}



-(void)applyData:(Interview *)interview
{
    _interview = [interview retain];
    
    _lblFirstName.text = interview.client.firstName;
    _lblLastName.text = interview.client.lastName;
    // format date
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"dd/MM/yyyy"];
	_lblLastVisited.text = [format stringFromDate:interview.client.lastVisitDate];
    
    _imgTick.hidden = (interview.visited == false);
}






#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end