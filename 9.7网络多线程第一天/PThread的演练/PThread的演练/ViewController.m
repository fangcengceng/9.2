//
//  ViewController.m
//  PThread的演练
//
//  Created by codygao on 16/9/6.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>

@interface ViewController ()

@end

@implementation ViewController
#pragma  pthread 演练。基于C语言
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self pthreaddemo];
    [NSThread currentThread];
}
-(void)pthreaddemo{
    //创建线程
    pthread_t ID;
  // 第四个参数： __bridge : 桥接
    //在C语言和OC语言混合开发时,用于类型强转之后的内存管理
   // 就是告诉编译器,如何管理C语言开辟的内存空间
    NSString *str = @"hello world";
    int result = pthread_create(&ID, NULL, demo, (__bridge void *)(str));
    if( result == 0 ){
        NSLog(@"%@",[NSThread currentThread]);
    }else{
        NSLog(@"创建线程失败");
    }
  
}
void *demo(void *paragma){
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"%@",paragma);
    return NULL;
}

@end
