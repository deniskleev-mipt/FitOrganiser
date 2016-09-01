

#import <Foundation/Foundation.h>

@interface CalendarObjectsGenerator : NSObject


+ (void)generateObjectsForDays:(NSInteger)countDays completionBlockDays:(CompletionBlockDays)completion;

@end
