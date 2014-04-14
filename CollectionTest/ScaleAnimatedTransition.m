//
//  ScaleAnimatedTransition.m
//  CollectionTest
//
//  Created by YUAN on 14-4-12.
//  Copyright (c) 2014年 Yuan Haisheng. All rights reserved.
//

#import "ScaleAnimatedTransition.h"
#import "ThumbnailViewController.h"

@implementation ScaleAnimatedTransition

- (void)executeForwardsAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    
    UIView* containerView = [transitionContext containerView];
    
    CGSize size = toView.frame.size;
    
    UIView *blackMask = [[UIView alloc] initWithFrame:fromView.frame];
    blackMask.backgroundColor = [UIColor blackColor];
    blackMask.alpha = 0.0;
    blackMask.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [containerView addSubview:blackMask];
    [containerView addSubview:toView];
    
    NSMutableArray *snapshots = [NSMutableArray new];
    
    CGFloat xFactor = 10.0f;
    CGFloat yFactor = xFactor * size.height / size.width;
    
    // snapshot the from view, this makes subsequent snaphots more performant
    UIView *fromViewSnapshot = [fromView snapshotViewAfterScreenUpdates:NO];
    
    // create a snapshot for each of the exploding pieces
//    for (CGFloat x=0; x < size.width; x+= size.width / xFactor) {
//        for (CGFloat y=0; y < size.height; y+= size.height / yFactor) {
//            CGRect snapshotRegion = CGRectMake(x, y, size.width / xFactor, size.height / yFactor);
//            UIView *snapshot = [fromViewSnapshot resizableSnapshotViewFromRect:snapshotRegion  afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
//            snapshot.frame = snapshotRegion;
//            [containerView addSubview:snapshot];
//            [snapshots addObject:snapshot];
//        }
//    }
    
//    [containerView sendSubviewToBack:fromView];
    toView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    // animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        toView.transform = CGAffineTransformIdentity;
        fromView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        fromView.alpha = 0.1;
//        for (UIView *view in snapshots) {
//            CGFloat xOffset = [self randomFloatBetween:-100.0 and:100.0];
//            CGFloat yOffset = [self randomFloatBetween:-100.0 and:100.0];
//            view.frame = CGRectOffset(view.frame, xOffset, yOffset);
//            view.alpha = 0.0;
//            view.transform = CGAffineTransformScale(CGAffineTransformMakeRotation([self randomFloatBetween:-10.0 and:10.0]), 0.0, 0.0);
//        }
    } completion:^(BOOL finished) {
        for (UIView *view in snapshots) {
            [view removeFromSuperview];
        }
        fromView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

-(void)executeReverseAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    UIView* containerView = [transitionContext containerView];
    
    CGSize size = toView.frame.size;
    
//    UIView *blackMask = [[UIView alloc] initWithFrame:fromView.frame];
//    blackMask.backgroundColor = [UIColor blackColor];
//    blackMask.alpha = 0.0;
//    blackMask.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    [containerView addSubview:blackMask];
    [containerView addSubview:toView];

}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return .5;
}

- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

#pragma mark - Get the size of view in the main screen
- (CGRect) viewBoundsWithOrientation:(UIInterfaceOrientation)orientation{
	CGRect bounds = [UIScreen mainScreen].bounds;
    if([[UIApplication sharedApplication]isStatusBarHidden]){
        return bounds;
    } else if(UIInterfaceOrientationIsLandscape(orientation)){
		CGFloat width = bounds.size.width;
		bounds.size.width = bounds.size.height;
        if (!SystemVersionGreaterOrEqualThan(7.0))  {
            bounds.size.height = width - 20;
        }else {
            bounds.size.height = width;
        }
        return bounds;
	}else{
        if (!SystemVersionGreaterOrEqualThan(7.0))  {
            bounds.size.height-=20;
        }
        return bounds;
    }
}

@end
