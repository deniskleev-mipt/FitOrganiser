//
//  BaseCollectionCell.m
//  CalendarTest
//
//  Created by Владимир Воробьев on 29.07.16.
//  Copyright © 2016 Vladimir. All rights reserved.
//

#import "BaseCollectionCell.h"

@implementation BaseCollectionCell

- (void)configureCellWithItem:(id)item {
    NSLog(@"must be overide by children");
}

@end
