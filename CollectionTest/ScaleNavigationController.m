//
//  MyNavigationControllerViewController.m
//  ViewControllerTransitions
//
//  Created by Colin Eberhardt on 09/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "ScaleNavigationController.h"
#import "AppDelegate.h"
#import "ScaleAnimatedTransition.h"
#import "SwipeInteractiveTransition.h"

@interface ScaleNavigationController () 

@end

@implementation ScaleNavigationController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
//        [self setup];
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.delegate = self;
    self.animatedTransition = [ScaleAnimatedTransition new];
    self.navigationControllerInteractionController = [SwipeInteractiveTransition new];
    self.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    // when a push occurs, wire the interaction controller to the to- view controller
    if (self.navigationControllerInteractionController) {
        [self.navigationControllerInteractionController wireToViewController:toVC forOperation:CEInteractionOperationPop];
    }
    
    if (self.animatedTransition) {
        self.animatedTransition.reverse = (operation == UINavigationControllerOperationPop);
    }
    
    return self.animatedTransition;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    
    // if we have an interaction controller - and it is currently in progress, return it
    return self.navigationControllerInteractionController && self.navigationControllerInteractionController.interactionInProgress ? self.navigationControllerInteractionController : nil;
}

@end
