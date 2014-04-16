//
//  ThumbnailViewController.m
//  CollectionTest
//
//  Created by yuan on 2014/04/09.
//  Copyright (c) 2014年 Yuan Haisheng. All rights reserved.
//

#import "ThumbnailViewController.h"
#import "DetailViewController.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define CELL_ID @"CELL_ID"

@implementation ThumbnailLayout

- (id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(157, 220);//254
    self.sectionInset = UIEdgeInsetsMake((iPhone5 ? 190 : 104), 2, 0, 2);
    self.minimumInteritemSpacing = 2.0f;
    self.minimumLineSpacing = 2.0f;
    
    return self;
}

@end

@implementation ThumbnailCell


@end

@interface ThumbnailViewController ()

@end

@implementation ThumbnailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCollectionViewLayout:(UICollectionViewFlowLayout *)layout
{
    if (self = [super initWithCollectionViewLayout:layout])
    {
//        self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
//        self.collectionView.dataSource = self;
//        self.collectionView.delegate = self;
//        [self.view addSubview:self.collectionView];
        
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
        [self.collectionView setBackgroundColor:[UIColor blackColor]];
        
    }
    return self;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 4;
    cell.clipsToBounds = YES;
    
    UIImageView *backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Cell"]];
    cell.backgroundView = backgroundView;
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([collectionView.collectionViewLayout class] == [ThumbnailLayout class]) {
//        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//        CGRect frame = [collectionView convertRect:cell.frame toView:self.view];
//        UIImageView *snapshotView = [[UIImageView alloc] initWithFrame:frame];
//        snapshotView.image = [cell snapshotImage];
//        cell.hidden = YES;
//        [self.view addSubview:snapshotView];
//    }
    self.selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    self.selectedFrame = [collectionView convertRect:self.selectedCell.frame toView:self.view];
    
    DetailViewController *vc = [[DetailViewController alloc] initWithCollectionViewLayout:[DetailLayout new]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
