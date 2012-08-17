#import <Foundation/Foundation.h>

#import "Client.h"

@interface Interview : NSObject
{
    NSString * _interviewId;
    NSDate * _startTime;
    NSDate * _endTime;
    double _cost;
    NSString * _comment;

    bool _visited;

    Client * _client;
}

// Properties
@property (strong, nonatomic) NSString * interviewId;
@property (strong, nonatomic) NSDate * startTime;
@property (strong, nonatomic) NSDate * endTime;
@property (nonatomic) double cost;
@property (strong, nonatomic) NSString * comment;
@property (nonatomic) bool visited;
@property (strong, nonatomic) Client * client;

@end
