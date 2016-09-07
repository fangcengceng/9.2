//
//  ViewController.m
//  线程的生命周期
//
//  Created by codygao on 16/9/6.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //[NSThread exit];
    //[self threaddemo1];
   // [self threaddemo2];
    [self threaddemo3];
}
#pragma 模拟线程延时操作
-(void)threaddemo3{
    [NSThread detachNewThreadSelector:@selector(demo3) toTarget:self withObject:@"detach"];
}
-(void)demo3{
    for (NSInteger i = 0; 1<10000; i++) {
        //每次线程都延缓1秒执行；
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"%zd%@",i ,[NSThread currentThread]);
        if(i==10){
            //线程从现在开始，3秒钟之后才开始执行；
            [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
            
        }
    }
}
#pragma 关于线程被取消的的状态
-(void)threaddemo2{
    NSThread *currentThread = [[NSThread alloc] initWithTarget:self selector:@selector(demo2) object:nil];
    [currentThread start];
    NSLog(@"这是线程被取消之前的状态");
     //模拟延时，线程的取消
    [NSThread sleepForTimeInterval:3];
    //只是改变了线程的状态，并不能真正的取消，需要在线程内部取消
    [currentThread cancel];
}
-(void)demo2{
    for(NSInteger i = 0; i<20000; i++){
        NSLog(@"%zd",i);
        if([NSThread currentThread].isCancelled){
            NSLog(@"线程被取消了");
            return;
        }
    }
}
#pragma 关于exit退出
-(void)threaddemo1{
    //创建线程
        //[NSThread exit];这个方法执行之后后面的代码将不能在执行；
    NSThread *currentThread = [[NSThread alloc] initWithTarget:self selector:@selector(demo1) object:nil];
    [currentThread start];
}

-(void)demo1{
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"在子线程中调用，exit方法，那么后面的代码还能执行吗？");
    [NSThread exit];
    NSLog(@"不能");
}

@end
