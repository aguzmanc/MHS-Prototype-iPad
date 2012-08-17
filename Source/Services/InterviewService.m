#import "InterviewService.h"

@implementation InterviewService

#pragma mark - Initialization

-(id)initWithListInterviewReceiverDelegate:(id<AsyncListInterviewReceiverDelegate>) delegate;                      
{
	self = [super init];
	
	_delegate = delegate;    
	
	return self;
}


@end
