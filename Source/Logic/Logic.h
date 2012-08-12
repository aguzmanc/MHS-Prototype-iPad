#import <Foundation/Foundation.h>

@protocol ViewChangerDelegate;

@interface Logic : NSObject
{
    // delegates
    id<ViewChangerDelegate> _viewChangerDelegate;
}

// Properties

// Initialization
-(id)initWithViewChangerDelegate:(id<ViewChangerDelegate>)viewChanger;

@end






/*
 *  VIEW CHANGER DELEGATE
 */

@protocol ViewChangerDelegate

-(void)switchToInitialization;
-(void)switchToAssignedInterviews;
-(void)switchToLogin;
-(void)switchToInterview;

@end