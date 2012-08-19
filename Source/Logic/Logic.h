#import <Foundation/Foundation.h>

#import "LoginUserService.h"
#import "PhotoService.h"
#import "Client.h"
#import "Interview.h"
#import "TotalSizeService.h"
#import "ClientService.h"
#import "InterviewService.h"

@protocol ViewChangerDelegate;
@protocol AssignedInterviewsDelegate;
@protocol LoginUserDelegate;
@protocol InitializationDelegate;

@interface Logic : NSObject <LoginUserServiceDelegate, AsyncProfileImageReceiverDelegate, 
                        TotalSizeServiceDelegate, AsyncListClientReceiverDelegate,
                        AsyncListInterviewReceiverDelegate>
{
    // delegates
    id<ViewChangerDelegate> _viewChangerDelegate;
    id<LoginUserDelegate> _loginUserDelegate;
    id<InitializationDelegate> _initializationDelegate;
    id<AssignedInterviewsDelegate> _assignedInterviewsDelegate;
    
    // Services
    LoginUserService * _loginUserService;
    ClientService * _clientService;
    InterviewService * _interviewService;
    
    // Logic data 
    NSArray * _interviewList;
    NSArray * _clientList;
    NSMutableDictionary * _userImageCache;
    NSMutableArray * _profileNumbersWaitingForPhoto;
    UIImage * _defaultImage;
    
    int _totalLoadSizeOfServices;
    int _totalBytesReceived;
    bool _isClientsResponseSizeKnown;
    bool _isInterviewsResponseSizeKnown;
    bool _clientsReceived;
    bool _interviewsReceived;
    
    NSString * _userIdLogged;
    
    Interview * _selectedInterview;
}

// Properties

@property (strong, nonatomic) NSArray * interviewList;

// Initialization
-(id)initWithViewChangerDelegate:(id<ViewChangerDelegate>)viewChanger
            andLoginUserDelegate:(id<LoginUserDelegate>)loginUsers
       andInitializationDelegate:(id<InitializationDelegate>)initialization
   andAssignedInterviewsDelegate:(id<AssignedInterviewsDelegate>)assignedInterviews;

// Public Methods
-(void)switchToInitialization;
-(void)switchToLogin;
-(void)switchToAssignedInterviews;
-(void)switchToInterview;


-(bool)existsImageForProfileNumber:(NSString *)profileNumber;
-(UIImage *)getImageForProfileNumber:(NSString *)profileNumber;
-(void)obtainImageForProfileNumber:(NSString *)profileNumber withFileName:(NSString *)fileName;

-(void)loginUser:(NSString *)user Pass:(NSString *)pass;

-(Interview *)getDummyInterview;
-(Interview *)getInterviewAt:(int)row ForWeekday:(int)weekday;

-(void)makeInterview:(Interview *)interview;
-(void)makeClientInterviewRelations;

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


/*
 *  Initializations DELEGATE
 */
@protocol InitializationDelegate

-(void)setLogic:(Logic *)logic;
//-(void)setIndex:(NSNumber *)index;
//-(void)updateProgressDelegate:(NSNumber *)indexProg TotalSize:(NSNumber *)totalSize;
-(void)updatePercentageProgress:(int)percentage;
@end



/*
 *  LOGIN DELEGATE
 */
@protocol LoginUserDelegate

-(void)setLogic:(Logic *)logic;
-(void)loginError:(NSString *)message;
-(void)errorLogin:(NSString *)message;

@end


/*
 *  ASSIGNED INTERVIEWS DELEGATE
 */
@protocol AssignedInterviewsDelegate

-(void)updateImage:(UIImage *)image forProfileNumber:(NSString *)profileNumber;

@end