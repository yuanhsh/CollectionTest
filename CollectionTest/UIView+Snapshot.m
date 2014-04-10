//
//  UIView+Snapshot.m
//  CollectionTest
//
//  Created by yuan on 2014/04/10.
//  Copyright (c) 2014年 Yuan Haisheng. All rights reserved.
//

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)

- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
//    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
//        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
//    } else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
