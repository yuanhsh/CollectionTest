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

@interface DetailViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIWebViewDelegate> {
    BOOL isLoading;
}
                                                             
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
                                                             
- (id)initWithCollectionViewLayout:(UICollectionViewFlowLayout *)layout;

@end
