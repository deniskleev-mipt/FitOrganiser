//
//  NoteCell.m
//  CalendarTest
//
//  Created by Владимир Воробьев on 29.07.16.
//  Copyright © 2016 Vladimir. All rights reserved.
//

#import "NoteCell.h"
#import "NoteObject.h"

@interface NoteCell ()


@property (weak, nonatomic) IBOutlet UILabel *noteDescription;
@end

@implementation NoteCell

- (void)configureCellWithItem:(id)item {

    if ([item isKindOfClass:[NoteObject class]]) {
        NoteObject *object = item;
        self.noteDescription.text = object.descriptionNote;
        
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap)];
        imageTap.cancelsTouchesInView = YES;
        imageTap.numberOfTapsRequired = 1;
        [self.markImage addGestureRecognizer:imageTap];
        
        if (object.isCompleted){
            [self.markImage setImage:[UIImage imageNamed:@"roundSelect.png"]];
        }
        
        else {
              [self.markImage setImage:[UIImage imageNamed:@"round.png"]];
        }
    }
}

- (void)handleImageTap {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickOnCellAtIndex:withData:)]) {
        [self.delegate didClickOnCellAtIndex:_cellIndex withData:nil];
    }
}


@end
