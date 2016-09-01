//
//  NoteCell.h
//  CalendarTest
//
//  Created by Владимир Воробьев on 29.07.16.
//  Copyright © 2016 Vladimir. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol CellDelegate;

@interface NoteCell : BaseTableViewCell
@property (weak, nonatomic)id <CellDelegate> delegate;
@property (assign, nonatomic) NSInteger cellIndex;
@property (weak, nonatomic) IBOutlet UIImageView *markImage;
@end

@protocol CellDelegate <NSObject>
- (void)didClickOnCellAtIndex:(NSInteger)cellIndex withData:(id)data;
@end
