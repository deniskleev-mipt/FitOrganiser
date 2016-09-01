//
//  GoodCell.m
//  CalendarTest
//
//  Created by Denis on 17.08.16.
//  Copyright © 2016 Vladimir. All rights reserved.
//

#import "GoodCell.h"

@implementation GoodCell {
    BOOL toSelect;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    /*
    toSelect = NO;
    [self.button setHighlighted:NO]; */
    // Initialization code
}

/*
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clicked:(id)sender {
    
    NSLog(self.nameLabel.text);
    if (toSelect == NO) {
        toSelect = YES;
        [self performSelector:@selector(doHighlight:) withObject:sender afterDelay:0];
    }
    else {
        toSelect = NO;
    }
    
}

- (void)doHighlight:(UIButton*)b {
    if (toSelect) {
        [self.button setHighlighted:YES];
    }
}
*/

/*
- (void) prepareForReuse {
    
}

*/

@end
