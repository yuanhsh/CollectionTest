//
//  NavigationControllerViewController.h
//  TransitionsDemo
//
//  Created by Colin Eberhardt on 10/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseAnimatedTransition.h"
#import "BaseInteractiveTransition.h"

@interface ScaleNavigationController : UINavigationController <UINavigationControllerDelegate>

@property (strong, nonatomic) BaseAnimatedTransition *animatedTransition;
@property (strong, nonatomic) BaseInteractiveTransition *navigationControllerInteractionController;

@end
