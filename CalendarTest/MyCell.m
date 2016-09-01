//
//  MyCell.m
//  Fitness
//
//  Created by Denis on 28.06.16.
//  Copyright © 2016 KDL. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _or.layer.cornerRadius = 7.0;
    _or.layer.masksToBounds = YES;
    _or.layer.borderColor = [UIColor whiteColor].CGColor;
    _or.layer.borderWidth = 2.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
