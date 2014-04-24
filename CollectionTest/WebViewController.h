//
//  WebViewController.h
//  YodoReader
//
//  Created by 苑　海勝 on 2014/03/13.
//  Copyright (c) 2014年 Kickmogu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NSString *urlPath;

- (id)initWithFrame:(CGRect)frame;

@end
