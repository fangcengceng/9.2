//
//  WEBViewController.m
//  代码二
//
//  Created by codygao on 16/9/6.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "WEBViewController.h"

@interface WEBViewController ()
@property(nonatomic,weak) UIWebView *webView;

@end

@implementation WEBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlName]];
    [webView loadRequest:request];
}

@end
