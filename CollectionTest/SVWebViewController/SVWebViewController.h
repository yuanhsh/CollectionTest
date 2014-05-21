//
//  SVWebViewController.h
//
//  Created by Sam Vermette on 08.11.10.
//  Copyright 2010 Sam Vermette. All rights reserved.
//
//  https://github.com/samvermette/SVWebViewController

#import "SVModalWebViewController.h"
#import "NJKScrollFullScreen.h"
#import "UIViewController+NJKFullScreenSupport.h"

@interface SVWebViewController : UIViewController<NJKScrollFullscreenDelegate>

- (id)initWithAddress:(NSString*)urlString;
- (id)initWithURL:(NSURL*)URL;
- (id)initWithURL:(NSURL*)URL delegate:(id<UIWebViewDelegate>) delegate;

@property (nonatomic, weak) id<UIWebViewDelegate> delegate;

@end
