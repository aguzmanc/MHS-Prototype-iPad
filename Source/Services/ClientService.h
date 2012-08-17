#import <Foundation/Foundation.h>

#import "Globals.h"

@protocol AsyncListClientReceiverDelegate;

@interface ClientService : NSObject
{
    id<AsyncListClientReceiverDelegate> _delegate;
    
    NSMutableData * _responseData;
    
}

// Initialization
-(id)initWithListClientReceiverDelegate:(id<AsyncListClientReceiverDelegate>) delegate; 
                         

@end

// Allows receive async response
@protocol AsyncListClientReceiverDelegate


@end