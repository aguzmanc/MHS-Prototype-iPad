#import "Logic.h"

@implementation Logic

#pragma mark Initialization

-(id)initWithViewChangerDelegate:(id<ViewChangerDelegate>)viewChanger
{
    self = [super init];
    
    _viewChangerDelegate = viewChanger;
    
    return self;
}




#pragma mark Public Methods

-(void)switchToInitialization
{
    [_viewChangerDelegate switchToInitialization];
}

@end
