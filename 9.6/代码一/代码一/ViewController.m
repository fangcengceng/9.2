//
//  ViewController.m
//  代码一
//
//  Created by codygao on 16/9/6.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDownloadDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property(nonatomic,strong)NSURLSessionDownloadTask *downloadTask;

@property(nonatomic,assign)float percent;
@end

@implementation ViewController{
    NSURLSession *_session;
    NSString * _filepath;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
}

- (IBAction)downloadclick:(id)sender {
    
    NSString *urlstr = @"http://202.38.193.200/xcb-vod/radio/diangetai/zhongwengequ/yuebanxiaoyequ%20tanyonglin.mp3";
    NSURL *URL = [NSURL URLWithString:urlstr];
    NSURLSessionDownloadTask *downloadTask = [_session downloadTaskWithURL:URL];
      [downloadTask resume];
     _downloadTask = downloadTask;
}
- (IBAction)pauseclick:(id)sender {
    [_downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        
    NSData *data = [NSData dataWithContentsOfFile:_filepath];
    if (data != nil){
        _downloadTask = [_session downloadTaskWithResumeData:data];
        [_downloadTask resume];
        [[NSFileManager defaultManager] removeItemAtPath:_filepath error:nil];
    }
        NSLog(@"%lu",resumeData.length);
        [resumeData writeToFile:_filepath atomically:YES];
        _downloadTask = nil;
    }];
}
#pragma  mark 监听下载方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    NSString *filepath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"hm.mp3"];
    _filepath = filepath;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager copyItemAtPath:location.path toPath:filepath error:nil];
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    float percent =(CGFloat) totalBytesWritten/totalBytesExpectedToWrite;
    NSLog(@"%f",percent);
   self.progressView.progress  = percent;
}
@end
