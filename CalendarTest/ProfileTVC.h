//
//  ProfileTVC.h
//  Fitness
//
//  Created by Denis on 26.06.16.
//  Copyright © 2016 KDL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMSimpleLineGraphView.h"

@interface ProfileTVC : UITableViewController <BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>

@property (strong) NSMutableArray *contactArray;
@property (strong) NSMutableArray *graphArray;
@property (weak, nonatomic) IBOutlet UILabel *minLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@property (weak, nonatomic) IBOutlet UILabel *weight;
@property (weak, nonatomic) IBOutlet UILabel *currentDelta;

- (void) updateMe2;

- (void) ggg ;
@end
