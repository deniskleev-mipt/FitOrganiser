

#import "CalendarCollectionManager.h"
#import "CalendarCell.h"

@implementation CalendarCollectionManager


- (NSString *)cellIdentifireForItem:(id)item {
    return @"CalendarCell";
}

- (void)configureCell:(UICollectionViewCell *)cell withItem:(id)item{
    if ([cell isKindOfClass:[CalendarCell class]]) {
        [(CalendarCell*)cell configureCellWithItem:item]; 
    }
}

- (void)reloadData {
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [self.delegate didSelectCalendarObject:[self itemByIndexPath:indexPath]];

}

@end
