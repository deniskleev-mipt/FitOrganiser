


#import "UICollectionViewManager.h"


@interface UICollectionViewManager ()
//@property (weak, nonatomic) IBOutlet UICollectionView *collectonView;
@property (copy, nonatomic)NSArray *items;
@end

@implementation UICollectionViewManager

@synthesize items = _items;


#pragma mark -LifeStyle

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {

    if (self = [super init]) {
      
        self.collectionView = collectionView;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        self.currentIndex = [NSIndexPath indexPathForRow:0 inSection:0];
     
    }
    return self;
}

- (void)reloadData {
    [self.collectionView reloadData];
}

#pragma mark -Configuration 

- (void)setItems:(NSArray *)items {
    _items = [items copy];
    [self.collectionView reloadData];

}

- (NSArray *)items{
    if (_items == nil) {
        _items = [NSArray array];
    }
    return _items;
}

- (void)addItems:(NSArray *)items {
    [self.collectionView performBatchUpdates:^{
        NSUInteger resultsSize = [self.items count];
        [self.items arrayByAddingObjectsFromArray:items];
        NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
        
        for (NSUInteger i = resultsSize; i < resultsSize + items.count; i++) {
            [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:i
                                                              inSection:0]];
        }
        [self.collectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
    } completion:nil];
}


#pragma mark - UICollectionViewDataSource 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return  [self.items count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellId = [self cellIdentifireForItem:nil];
    UICollectionViewCell *cell = nil;
    cell=(UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [self configureCell:cell withItem: [self itemByIndexPath:indexPath]];
    return cell;

}


- (void)configureCell:(UICollectionViewCell *)cell withItem:(id)item {
 NSAssert(NO, @"configureCellForItem should be overriden in childs");
}


- (NSString *)cellIdentifireForItem:(id)item{
    return nil;
}

- (id)itemByIndexPath:(NSIndexPath *)indexPath {
    id item = nil;
    item = self.items[indexPath.row];
    
    return item;
}

-(UICollectionViewCell*)cellByIndexPath:(NSIndexPath *)indexPath {
 
    UICollectionViewCell *cell = nil;
    cell = [self collectionView:self.collectionView cellForItemAtIndexPath:indexPath];
    return cell; 
}


@end
