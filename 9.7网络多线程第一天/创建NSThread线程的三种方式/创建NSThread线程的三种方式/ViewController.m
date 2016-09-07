//
//  ViewController.m
//  创建NSThread线程的三种方式
//
//  Created by codygao on 16/9/6.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self threaddemo1];
    [self threaddemo2];
    [self threaddemo3];
}

-(void)threaddemo3{
    [NSThread detachNewThreadSelector:@selector(demo3:) toTarget:self withObject:@"detach"];
}
-(void)threaddemo2{
    [[NSThread alloc] performSelectorInBackground:@selector(demo2:) withObject:@"perform"];
}
-(void)threaddemo1{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(demo1:) object:@"start"];
    [thread start];
}
-(void)demo1:(NSString *)parag{
    NSLog(@"参数==%@ ,当前线程是%@",parag, [NSThread currentThread]);
}
-(void)demo2:(NSString *)parag{
     NSLog(@"参数==%@ ,当前线程是%@",parag, [NSThread currentThread]);
}
-(void)demo3:(NSString *)parag{
     NSLog(@"参数==%@ ,当前线程是%@",parag, [NSThread currentThread]);
}
@end
