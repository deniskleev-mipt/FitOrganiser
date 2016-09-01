

#import "CalendarObjectsGenerator.h"
#import "DateManager.h"
#import "CalendarObject.h"


@interface CalendarObjectsGenerator()
@property (copy, nonatomic)NSArray *datesArray;
@end

@implementation CalendarObjectsGenerator

+ (void)generateObjectsForDays:(NSInteger)countDays completionBlockDays:(CompletionBlockDays)completion {
    

    
    
     __block NSArray *datesAray;

    [DateManager getDatesForDays:countDays completionBlock:^(id object, NSError *error) {
        if ([object isKindOfClass:[NSArray class]]) {
            datesAray = object;
            NSMutableArray *resultObjectsArray = [NSMutableArray new];
            NSUInteger index = 0;
            for (int i = 0; i < datesAray.count; i++){
                CalendarObject *object = [[CalendarObject alloc]init];
                NSDate *currdate = datesAray[i];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                
                NSDate *nowdate = [NSDate date];
                NSDateFormatter *dateNowFormatter = [[NSDateFormatter alloc] init];
                
                [dateFormatter setDateFormat:@"dd"];
                object.day = [dateFormatter stringFromDate:currdate];
                
                [dateFormatter setDateFormat:@"MMM"];
                object.month = [dateFormatter stringFromDate:currdate];
                
                [dateFormatter setDateFormat:@"yyyy"];
                object.year = [dateFormatter stringFromDate:currdate];
                
                [dateFormatter setDateFormat:@"EE"];
                object.dayName = [dateFormatter stringFromDate:currdate];
                
                [dateNowFormatter setDateFormat:@"dd"];
                NSString *nowDateDay = [dateNowFormatter stringFromDate:nowdate];
                if ([object.day isEqualToString:nowDateDay]){
                    index = i;
                    NSLog(@"equality date %lu", (unsigned long)index);
                }
                [resultObjectsArray addObject:object];
                
                NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                [gregorian setFirstWeekday:2]; // Sunday == 1, Saturday == 7
                NSUInteger adjustedWeekdayOrdinal = [gregorian ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:currdate];
                
                object.numberDaysOfWeek = adjustedWeekdayOrdinal;
                object.notes = [NSMutableArray new];
            }
            completion(resultObjectsArray,index, nil);
        }
       
        
    }];
    
}




@end
