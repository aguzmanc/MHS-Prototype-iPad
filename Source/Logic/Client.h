#import <Foundation/Foundation.h>

@interface Client : NSObject
{
    NSString * _firstName;
    NSString * _lastName;
    NSDate * _lastVisitedDate;
    NSString * _profileNumber;
    int _age;
    NSDate * _birthDate;
    
    NSArray * _interviews;
}

@end
