

#import <Foundation/Foundation.h>

@interface DateManager : NSObject

+ (void)getDatesForDays:(NSInteger)countDays completionBlock:(CompletionBlock)completion;

@end
