#import <Foundation/Foundation.h>

#import "Globals.h"

@protocol AsyncListInterviewReceiverDelegate;

@interface InterviewService : NSObject
{
    id<AsyncListInterviewReceiverDelegate> _delegate;
    
    NSMutableData * _responseData;
    
}

// Initialization
-(id)initWithListInterviewReceiverDelegate:(id<AsyncListInterviewReceiverDelegate>) delegate; 


@end

// Allows receive async response
@protocol AsyncListInterviewReceiverDelegate


@end

