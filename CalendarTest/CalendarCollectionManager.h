

#import "UICollectionViewManager.h"
@protocol CalendarCollectionManagerDelegate;

@interface CalendarCollectionManager : UICollectionViewManager

@property (weak, nonatomic)id <CalendarCollectionManagerDelegate>delegate;

@end

@protocol CalendarCollectionManagerDelegate <NSObject>

- (void)didSelectCalendarObject:(id)item;

@end
