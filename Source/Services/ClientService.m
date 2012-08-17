#import "ClientService.h"

@implementation ClientService


#pragma mark - Initialization

-(id)initWithListClientReceiverDelegate:(id<AsyncListClientReceiverDelegate>) delegate;                      
{
	self = [super init];
	
	_delegate = delegate;    
	
	return self;
}


@end
