
#import "CalendarCell.h"
#import "CalendarObject.h"

@interface CalendarCell ()
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *daycount;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation CalendarCell

- (void)configureCellWithItem:(id)item {
    if ([item isKindOfClass:[CalendarObject class]]) {
        CalendarObject *object = item;
        self.day.text = object.dayName;
        self.daycount.text = object.day;
        [self.day setTextColor:[self dayTextColorWithObject:object]];
    }
}


-(void)setSelected:(BOOL)selected {

    if (selected){
        self.bottomView.hidden = NO;
      
    }
    else {
        self.bottomView.hidden = YES; 
    }
}






- (UIColor*)dayTextColorWithObject:(id)item {
     UIColor *color;

    if ([item isKindOfClass:[CalendarObject class]]) {
        CalendarObject *object = item;
   
        if (object.numberDaysOfWeek ==6 || object.numberDaysOfWeek == 7){
            color = [UIColor redColor];
        }
        else {
            color = [UIColor colorWithRed:86/255.0f green:88/255.0f blue:94/255.0f alpha:1.0f];
        }
        }
   
    
    
    return color;
}

@end
