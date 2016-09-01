//
//  TCDTableManager.h
//  PseudoSafari
//
//  Created by Dmitriy Doroschuk on 15.03.16.
//  Copyright © 2016 TCD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKNTableManager : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic, readonly) UITableView *tableView;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTableView:(UITableView *)tableView NS_DESIGNATED_INITIALIZER;

- (void)setItems:(NSArray *)items;
- (NSArray *)items;
- (void)addItems:(NSArray *)items;

/// For further: in current implementation only 1 section supports.
- (id)itemByIndexPath:(NSIndexPath *)indexPath;
- (id)itemByCell:(UITableViewCell *)cell;
- (UITableViewCell *)cellByItem:(id)item;

// must be override
- (NSString *)cellIdentifireForItem:(id)item;
- (CGFloat)heightForItem:(id)item fromTableView:(UITableView*)tableView;
- (void)configureCell:(UITableViewCell *)cell withItem:(id)item byIndexPath:(NSIndexPath*)indexPath;
- (void)reloadData;

@end
