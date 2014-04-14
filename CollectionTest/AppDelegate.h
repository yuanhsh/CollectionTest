//
//  AppDelegate.h
//  CollectionTest
//
//  Created by yuan on 2014/04/09.
//  Copyright (c) 2014年 Yuan Haisheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScaleNavigationController.h"

#define ApplicationDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@class BaseAnimatedTransition, BaseInteractiveTransition;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ScaleNavigationController *navigationController;
//@property (strong, nonatomic) BaseAnimatedTransition *navigationAnimatedTransition;
//@property (strong, nonatomic) BaseInteractiveTransition *navigationInteractiveTransition;

@end
