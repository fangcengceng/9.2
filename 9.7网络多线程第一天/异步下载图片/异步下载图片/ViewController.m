//
//  ViewController.m
//  异步下载图片
//
//  Created by codygao on 16/9/7.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,weak)UIImageView *imageView;
@property(nonatomic,weak)UIScrollView *scrollview;

@end

@implementation ViewController
-(void)loadView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.backgroundColor = [UIColor redColor];
    self.view = scrollView;
    self.scrollview = scrollView;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [NSThread detachNewThreadSelector:@selector(downloadImage1) toTarget:self withObject:nil];
  
}
-(void)downloadImage1{
   NSString *urlstr = @"http://img001.21cnimg.com/photos/album/20160807/m600/24843E1B394060C7B8E8A87662D74EE8.jpeg";
    NSURL *URL = [NSURL URLWithString:urlstr];
    NSData *data = [NSData dataWithContentsOfURL:URL];
    UIImage *image = [UIImage imageWithData:data];
    [[NSThread alloc] performSelectorOnMainThread:@selector(updateUI:) withObject:downloadImage waitUntilDone:NO];
}
-(void)updateUI:(UIImage*)image{
    self.imageView.image = downloadImage;
    [self.imageView sizeToFit];
    [self.scrollview setContentSize:downloadImage.size];
}
@end
