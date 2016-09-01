

#import "DateManager.h"

@implementation DateManager

+ (void)getDatesForDays:(NSInteger)countDays completionBlock:(CompletionBlock)completion {
    
    //------------------------GET START DATE-------------------------//
    NSDate *startDate;
    startDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"FIRST_START_DATE"];
    if (!startDate) {
        startDate = [NSDate date];
        //startDate = [startDate dateByAddingTimeInterval: -(86400.0 *2)];
        [[NSUserDefaults standardUserDefaults] setObject:startDate forKey:@"FIRST_START_DATE"]; // Save date
    }
    
    NSInteger daysBefore = [self daysBetweenDate:startDate andDate:[NSDate date]];
    if (daysBefore < 0){
        daysBefore = 0;
    }

    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ) fromDate:[[NSDate alloc] init]];
    
    [components setHour:-[components hour]];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    
    NSMutableArray * days = [[NSMutableArray alloc]init];
    NSDate *currentDate = startDate;
    for (int i=0; i < countDays + daysBefore; i++) {
        
        NSDate *date = [cal dateByAddingComponents:components toDate:currentDate options:0];

        
        NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
        NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:date];
        NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:date];
        NSTimeInterval gmtInterval = currentGMTOffset - gmtOffset;
        NSDate *destinationDate = [[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:date];
    
        [days addObject:destinationDate];
        
        [components setHour:+24];
        [components setMinute:0];
        [components setSecond:0];
         currentDate = date;
    }
    
    completion(days, nil);



}


+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

@end
