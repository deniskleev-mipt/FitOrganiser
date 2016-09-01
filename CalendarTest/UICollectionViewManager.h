//
//  UICollectionViewManager.h
//  Ovation
//
//  Created by Vladimir on 04.07.16.
//  Copyright © 2016 OV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UICollectionViewManager : NSObject <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic)NSIndexPath *currentIndex; 

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

- (void)setItems:(NSArray *)items;
- (NSArray *)items;
- (void)addItems:(NSArray *)items;

-(UICollectionViewCell*)cellByIndexPath:(NSIndexPath*)indexPath;
- (id)itemByIndexPath:(NSIndexPath *)indexPath;

//for override 
- (NSString *)cellIdentifireForItem:(id)item;
- (void)configureCell:(UICollectionViewCell *)cell withItem:(id)item;
- (void)reloadData;


@end
