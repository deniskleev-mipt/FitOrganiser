//
//  TCDTableManager.m
//  PseudoSafari
//
//  Created by Dmitriy Doroschuk on 15.03.16.
//  Copyright © 2016 TCD. All rights reserved.
//

#import "TKNTableManager.h"


@interface TKNTableManager ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray *items;

@end

@implementation TKNTableManager

@synthesize items = _items;

#pragma mark - LifeStyle

- (instancetype)initWithTableView:(UITableView *)tableView {
    if (self = [super init]) {
       
        self.tableView = tableView;
        tableView.dataSource = self;
        tableView.delegate = self;
       
    }
    
    return self;
}

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - Configure

- (void)setItems:(NSArray *)items {
    _items = [items copy];
    [self.tableView reloadData];
}

- (NSArray *)items {
    if (_items == nil) {
        _items = [NSArray array];
    }
    return _items;
}

- (void)addItems:(NSArray *)items {
    [self.tableView beginUpdates];
    
    self.items = [self.items arrayByAddingObjectsFromArray:items];
    
    NSMutableArray <NSIndexPath *> *indexPaths = [NSMutableArray array];
    for (NSUInteger i = [self.items indexOfObject:items.firstObject]; i < self.items.count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationMiddle];
    
    [self.tableView endUpdates];
}

- (void)setTableView:(UITableView *)tableView {
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    
    _tableView = tableView;
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfRowsInSection:0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellId = [self cellIdentifireForItem:[self itemByIndexPath:indexPath]];
    UITableViewCell *cell = nil;
    @try {
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        [self configureCell:cell withItem:[self itemByIndexPath:indexPath] byIndexPath:indexPath];
        
    }
    @catch (NSException *exception) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"some not real cell id"];
    }
   
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForItem:[self itemByIndexPath:indexPath] fromTableView:tableView];
}

#pragma mark - From Childs

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section {
    ///enough for current feature
    return self.items.count;
}

- (id)itemByIndexPath:(NSIndexPath *)indexPath {
    id item = nil;
    @try {
        item = self.items[indexPath.row];
    }
    @catch (NSException *exception) {}
    
    return item;
}

- (NSIndexPath *)indexPathForItem:(id)item {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.items indexOfObject:item] inSection:0];
    
    return indexPath;
}

- (id)itemByCell:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath == nil) {
        NSParameterAssert(indexPath);
        
        return nil;
    }
    return [self itemByIndexPath:indexPath];
}

- (UITableViewCell *)cellByItem:(id)item {
    
    return [self.tableView cellForRowAtIndexPath:[self indexPathForItem:item]];
}

- (CGFloat)heightForItem:(id)item fromTableView:(UITableView *)tableView {
    return 44.;
}

- (NSString *)cellIdentifireForItem:(id)item {
    @throw [NSException exceptionWithName:@"no cell identifire" reason:@"cellIdentifire should be provided by childs of TCDTableViewManager" userInfo:nil];
    
    return nil;
}

- (void)configureCell:(UITableViewCell *)cell withItem:(id)item {
    NSAssert(NO, @"configureCellForItem should be overriden in childs");
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
