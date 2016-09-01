

#import <Foundation/Foundation.h>

@interface CalendarObject : NSObject

@property (strong, nonatomic)NSString *dayName;
@property (strong, nonatomic)NSString *day;
@property (strong, nonatomic)NSString *month;
@property (strong, nonatomic)NSString*year;
@property (assign, nonatomic)NSInteger numberDaysOfWeek; 
@property (strong, nonatomic)NSMutableArray *notes;

@end
