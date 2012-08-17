#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

#pragma mark Event Handlers

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // create and setup main window
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [self.window makeKeyAndVisible];
    
    // Setup Controllers first
    _loginController = [[LoginController alloc] initWithLogic:_logic];
    _initializationController = [[InitializationController alloc] initWithLogic:_logic];
    _assignedInterviewsController = [[AssignedInterviewsController alloc] init];
    _interviewController = [[InterviewController alloc] initWithLogic:_logic];
    
    // Setup Logic
    _logic = [[Logic alloc] initWithViewChangerDelegate:self 
                          andAssignedInterviewsDelegate:_assignedInterviewsController];
    
    // Assign Logic to all Controllers
    [_assignedInterviewsController setLogic:_logic];
    
    //[_logic switchToInitialization];
    [_logic switchToAssignedInterviews];
    // Setup View at the beginning
    [_logic switchToInitialization];
    //[_logic switchToAssignedInterviews];
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}



- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}



- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}



- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}



- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark View Changer Delegate

-(void)switchToInitialization
{
    self.window.rootViewController = _initializationController;
}



-(void)switchToAssignedInterviews
{
    self.window.rootViewController = _assignedInterviewsController;
    [_assignedInterviewsController reloadTable];
}



-(void)switchToLogin
{
    self.window.rootViewController = _loginController;
}



-(void)switchToInterview
{
    self.window.rootViewController =  _interviewController;
}





#pragma mark Memory Management

- (void)dealloc
{
    [_window release];
    [_loginController release];
    [_assignedInterviewsController release];
    [super dealloc];
}





@end
