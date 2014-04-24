//
//  WebViewController.m
//  YodoReader
//
//  Created by 苑　海勝 on 2014/03/13.
//  Copyright (c) 2014年 Kickmogu. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.view.frame = frame;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.webView];
    self.view.backgroundColor = [UIColor whiteColor];
	self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlPath]]];
    for(UIView *v in [[[self.webView subviews] objectAtIndex:0] subviews]) {
        if([v isKindOfClass:[UIImageView class]]) {
            v.hidden = YES;
        }
    }
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
//    [self.indicatorView startAnimating];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
//    [self.indicatorView stopAnimating];
//    UIView *view = (UIView*)[self.view viewWithTag:kIndicatorViewTag];
//    [view removeFromSuperview];
//    NSLog(@"webViewDidFinishLoad");
//    self.webView.hidden = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    [self.indicatorView stopAnimating];
//    UIView *view = (UIView*)[self.view viewWithTag:kIndicatorViewTag];
//    [view removeFromSuperview];
//    NSLog(@"didFailLoadWithError");
}


@end
