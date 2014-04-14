//
//  DetailViewController.h
//  CollectionTest
//
//  Created by YUAN on 14-4-12.
//  Copyright (c) 2014年 Yuan Haisheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailLayout: UICollectionViewFlowLayout

@end

@interface DetailViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
                                                             
@property (nonatomic, strong) UICollectionView *collectionView;
                                                             
- (id)initWithCollectionViewLayout:(UICollectionViewFlowLayout *)layout;

@end
