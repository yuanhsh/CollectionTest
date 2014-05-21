//
//  DetailViewController.m
//  CollectionTest
//
//  Created by YUAN on 14-4-12.
//  Copyright (c) 2014年 Yuan Haisheng. All rights reserved.
//

#import "DetailViewController.h"
#import "UIView+Snapshot.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define CELL_ID @"CELL_ID"
#define kIndicatorViewTag 108

@implementation DetailLayout

- (id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(CGRectGetWidth([[UIScreen mainScreen] bounds]), CGRectGetHeight([[UIScreen mainScreen] bounds]));
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumInteritemSpacing = 10.0f;
    self.minimumLineSpacing = 4.0f;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [self layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        if (layoutAttributes.representedElementCategory != UICollectionElementCategoryCell)
            continue; // skip headers
        
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
            
            layoutAttributes.alpha = 0;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}


@end

@interface DetailViewController ()

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init {
    return [self initWithCollectionViewLayout:[DetailLayout new]];
}

- (id)initWithCollectionViewLayout:(UICollectionViewFlowLayout *)layout
{
    if (self = [super init])
    {
        self.layout = layout;
        self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self.view addSubview:self.collectionView];
    }
    return self;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
    [self.collectionView setBackgroundColor:[UIColor blackColor]];
    self.layout.itemSize = self.collectionView.frame.size;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
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
//    [self.navigationController popViewControllerAnimated:YES];
//    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
//    self.webView.delegate = self;
//    self.webView.hidden = YES;
//    [self.view addSubview:self.webView];
    
    
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 32.0f, 32.0f)];
    view.userInteractionEnabled = YES;
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(indicatorDragged:)];
	[view addGestureRecognizer:gesture];
    [view setTag:kIndicatorViewTag];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.3];
    view.layer.cornerRadius = 5.0f;
    view.clipsToBounds = YES;
    [self.view addSubview:view];
    
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
//    [self.indicatorView setCenter:view.center];
    [self.indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:self.indicatorView];
    
    NSString *path = @"http://www.google.com";
    NSURL *url = [NSURL URLWithString:path];
    isLoading = YES;
    self.webVC = [[SVModalWebViewController alloc] initWithURL:url delegate:self];
    self.webVC.view.hidden = YES;
    [self.view addSubview:self.webVC.view];
    [self addChildViewController:self.webVC];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)indicatorDragged:(UIPanGestureRecognizer *)gesture
{
	UIView *view = (UILabel *)gesture.view;
	CGPoint translation = [gesture translationInView:view];
	// move view
	view.center = CGPointMake(view.center.x + translation.x, view.center.y + translation.y);
	// reset translation
	[gesture setTranslation:CGPointZero inView:view];
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
    [self.indicatorView startAnimating];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
    if (isLoading) {
        isLoading = NO;
        [self.indicatorView stopAnimating];
        UIView *view = (UIView*)[self.view viewWithTag:kIndicatorViewTag];
        [view removeFromSuperview];
        
//        [self presentViewController:self.webVC animated:YES completion:nil];
        CATransform3D transform = CATransform3DMakeScale(0.01, 0.01, 1);
        UIView *target = self.webVC.view; //self.webView
        target.layer.transform = transform;
        [UIView animateWithDuration:0.2f animations:^{
            target.layer.transform = CATransform3DIdentity;
            target.hidden = NO;
        } completion:^(BOOL finished) {
            [self.webVC didMoveToParentViewController:self];
        }];
    }
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.indicatorView stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:kIndicatorViewTag];
    [view removeFromSuperview];
    NSLog(@"didFailLoadWithError");
}

@end
