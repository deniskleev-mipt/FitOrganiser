//
//  MyCell.h
//  Fitness
//
//  Created by Denis on 28.06.16.
//  Copyright © 2016 KDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dayName;
@property (weak, nonatomic) IBOutlet UILabel *ddmm;
@property (weak, nonatomic) IBOutlet UILabel *weight;
@property (weak, nonatomic) IBOutlet UILabel *delta;
@property (weak, nonatomic) IBOutlet UILabel *orange;
@property (weak, nonatomic) IBOutlet UIImageView *or;
@end
