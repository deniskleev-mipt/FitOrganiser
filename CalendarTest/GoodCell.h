//
//  GoodCell.h
//  CalendarTest
//
//  Created by Denis on 17.08.16.
//  Copyright © 2016 Vladimir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (IBAction)clicked:(id)sender;
@end
