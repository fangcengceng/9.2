//
//  ViewController.m
//  线程属性
//
//  Created by codygao on 16/9/7.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)NSThread *newthread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"当前线程所占内存的大小%lu,当前线程是否是主线程%d",[NSThread currentThread].stackSize,[NSThread currentThread].isMainThread);
    [self threaddemo];
}
-(void)threaddemo{
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(demo) object:nil];
    [thread1 start];
    thread1.name = @"thread1name";
    NSLog(@"优先级==%f",thread1.threadPriority);
    _newthread = thread1;
}
-(void)demo{
    NSLog(@"demo线程 == %@ ",[NSThread currentThread]);
    NSLog(@"子线程==%tu",[NSThread currentThread].stackSize/1024);
    NSLog(@"%@",_newthread);
}
@end
