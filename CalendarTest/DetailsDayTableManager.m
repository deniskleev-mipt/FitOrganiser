

#import "DetailsDayTableManager.h"
#import "NoteCell.h"
#import "NoteObject.h"


@interface DetailsDayTableManager () <CellDelegate>

@end

@implementation DetailsDayTableManager


- (NSString *)cellIdentifireForItem:(id)item {
    return @"NoteCell";
}

- (void)configureCell:(UITableViewCell *)cell withItem:(id)item byIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[NoteCell class]]) {
        NoteCell *note =(NoteCell*) cell;
        [note configureCellWithItem:item];
        note.delegate = self;
        note.cellIndex = indexPath.row;
    }
}


#pragma  mark -CellDelegate 

- (void)didClickOnCellAtIndex:(NSInteger)cellIndex withData:(id)data {
    NoteObject *object = [self itemByIndexPath:[NSIndexPath indexPathForRow:cellIndex inSection:0]];
    NoteCell *markcell = [self cellByItem:object];
    NSLog(@"object is completed before select %d", object.isCompleted);
   [markcell.markImage setImage:[UIImage imageNamed:@"22.png"]];
    if (object.isCompleted){

       [markcell.markImage setImage:[UIImage imageNamed:@"round.png"]];
        object.isCompleted = NO;
    }
    else {
        [markcell.markImage setImage:[UIImage imageNamed:@"roundSelect.png"]];
        object.isCompleted = YES;
    }
 }

@end
