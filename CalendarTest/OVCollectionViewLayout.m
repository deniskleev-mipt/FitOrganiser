//
//  OVCollectionViewLayout.m
//  Ovation
//
//  Created by Vladimir on 04.07.16.
//  Copyright © 2016 OV. All rights reserved.
//

#import "OVCollectionViewLayout.h"

@interface OVCollectionViewLayout ()

@property (nonatomic, strong)NSArray *layoutArr;
@property (nonatomic, assign)CGSize currentContentSize;



@end

@implementation OVCollectionViewLayout


- (void)prepareLayout
{
    [super prepareLayout];
    self.layoutArr = [self generateLayout];
}

- (CGSize)collectionViewContentSize
{
    return self.currentContentSize;
}


-(NSArray*)generateLayout {
    
    NSMutableArray *arr = [NSMutableArray new];
    NSInteger sectionCount = 1;
    if ([self.collectionView.dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        sectionCount = [self.collectionView.dataSource numberOfSectionsInCollectionView:self.collectionView];
    }
    CGSize cellSize = self.cellSize;
    float xOffset = 0;
    float yOffset = 0;
    
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemsCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:section];
        for (NSInteger item = 0; item < itemsCount; item++){
            NSIndexPath *idxPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:idxPath];
            attrs.frame = CGRectMake(xOffset, yOffset, cellSize.width, cellSize.height);
            [arr addObject:attrs];
            
            xOffset += cellSize.width + self.sectionSpacing.width;
        
        }
        
    }
    
    self.currentContentSize = CGSizeMake(xOffset, yOffset);
    return arr;
  
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.layoutArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    for (UICollectionViewLayoutAttributes *attrs in self.layoutArr) {
        if ([attrs.indexPath isEqual:indexPath]) {
            return attrs;
        }
    }
    return nil;
}

@end
