//
//  ThumbnailViewController.h
//  CollectionTest
//
//  Created by yuan on 2014/04/09.
//  Copyright (c) 2014年 Yuan Haisheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Snapshot.h"

@interface ThumbnailLayout: UICollectionViewFlowLayout

@end

@interface ThumbnailCell : UICollectionViewCell

@end

@interface ThumbnailViewController : UICollectionViewController /*<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

- (id)initWithCollectionViewLayout:(UICollectionViewFlowLayout *)layout; */

@property (nonatomic, strong) UICollectionViewCell *selectedCell;

//@property (nonatomic, strong) UICollectionViewLayoutAttributes *selectedAttributes;

@property (nonatomic, assign) CGRect selectedFrame;

@end
