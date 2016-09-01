

#import <Foundation/Foundation.h>

@interface Constants : NSObject

typedef void (^CompletionBlock)(id object, NSError *error);
typedef void (^CompletionBlockDays)(id object, NSInteger index, NSError *error); 


@end
