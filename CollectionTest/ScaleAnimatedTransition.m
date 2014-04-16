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
    ThumbnailViewController *thumbVC = (ThumbnailViewController *)fromVC;
    
    UIView *blackMask = [[UIView alloc] initWithFrame:fromView.frame];
    blackMask.backgroundColor = [UIColor blackColor];
    blackMask.alpha = 0.0;
    blackMask.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    [containerView addSubview:blackMask];
    
//    UIImageView *snapshotView = [[UIImageView alloc] initWithFrame:thumbVC.selectedAttributes.frame];
//    snapshotView.image = [thumbVC.selectedCell snapshotImage];
//    [containerView addSubview:snapshotView];
//    snapshotView.alpha = 1;
    
    //toView.alpha = 0.0f;
    
    [containerView addSubview:toView];
    
    CGPoint startCenter = [self getPointFromFrame:thumbVC.selectedFrame];;
    CGFloat xTranslate = startCenter.x - toView.center.x;
    CGFloat yTranslate = startCenter.y - toView.center.y;
    CGFloat xFactor = CGRectGetWidth(thumbVC.selectedFrame) / CGRectGetWidth(toView.frame);
    CGFloat yFactor = CGRectGetHeight(thumbVC.selectedFrame) / CGRectGetHeight(toView.frame);
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(xTranslate, yTranslate);
    toView.transform = CGAffineTransformScale(transform, xFactor, yFactor);
    
    // snapshot the from view, this makes subsequent snaphots more performant
//    UIView *fromViewSnapshot = [fromView snapshotViewAfterScreenUpdates:NO];
    
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
//    thumbVC.selectedCell.hidden = YES;
    // animate
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        toView.transform = CGAffineTransformIdentity;
        fromView.transform = CGAffineTransformMakeScale(0.95, 0.95);
        fromView.alpha = 0.7;
        toView.alpha = 1.0;
        thumbVC.selectedCell.alpha = 0.0;
//        snapshotView.alpha = 0;
//        for (UIView *view in snapshots) {
//            CGFloat xOffset = [self randomFloatBetween:-100.0 and:100.0];
//            CGFloat yOffset = [self randomFloatBetween:-100.0 and:100.0];
//            view.frame = CGRectOffset(view.frame, xOffset, yOffset);
//            view.alpha = 0.0;
//            view.transform = CGAffineTransformScale(CGAffineTransformMakeRotation([self randomFloatBetween:-10.0 and:10.0]), 0.0, 0.0);
//        }
    } completion:^(BOOL finished) {

        fromView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

-(void)executeReverseAnimation:(id<UIViewControllerContextTransitioning>)transitionContext fromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC fromView:(UIView *)fromView toView:(UIView *)toView {
    UIView* containerView = [transitionContext containerView];
     ThumbnailViewController *thumbVC = (ThumbnailViewController *)toVC;
    
//    UIView *blackMask = [[UIView alloc] initWithFrame:fromView.frame];
//    blackMask.backgroundColor = [UIColor blackColor];
//    blackMask.alpha = 0.0;
//    blackMask.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    [containerView addSubview:blackMask];
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];
    
    CGPoint startCenter = [self getPointFromFrame:thumbVC.selectedFrame];
    CGFloat xTranslate =  startCenter.x - fromView.center.x;
    CGFloat yTranslate = startCenter.y - fromView.center.y;
    CGFloat xFactor = CGRectGetWidth(thumbVC.selectedFrame) / CGRectGetWidth(toView.frame);
    CGFloat yFactor = CGRectGetHeight(thumbVC.selectedFrame) / CGRectGetHeight(toView.frame);
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(xTranslate, yTranslate);
    transform = CGAffineTransformScale(transform, xFactor, yFactor);
    
    toView.transform = CGAffineTransformMakeScale(0.95, 0.95);
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        
        fromView.transform = transform;
        fromView.alpha = 1.0;
        toView.alpha = 1.0;
        toView.transform = CGAffineTransformIdentity;
        thumbVC.selectedCell.alpha = 0.5;

    } completion:^(BOOL finished) {
        thumbVC.selectedCell.alpha = 1.0;
        fromView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];

}

- (CGPoint)getPointFromFrame:(CGRect)frame {
    CGFloat x = frame.origin.x + frame.size.width / 2.0f;
    CGFloat y = frame.origin.y + frame.size.height / 2.0f;
    return CGPointMake(x, y);
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
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
