#import <Foundation/Foundation.h>


@protocol InterviewSaveServiceDelegate;

@interface InterviewSave : NSObject
{
	NSMutableData * responseData;
	NSMutableString * responseString;
	
	id<InterviewSaveServiceDelegate> _delegate;
}

// Initialization
-(id)initWithDelegate:(id<InterviewSaveServiceDelegate>)delegate;


-(void)interviewSaves:(NSString *)interviewId andStarTime:(NSString *)startime andEndTime:(NSString *)endtime andTimespent:(NSString *)timespent andCommint:(NSString *)commint andCost:(NSString *)cost;

@end


@protocol InterviewSaveServiceDelegate

-(void)successInterviewSave:(BOOL)status andMessage:(NSString *)message;
-(void)errorInterviewSaveService:(NSString *)message;

@end