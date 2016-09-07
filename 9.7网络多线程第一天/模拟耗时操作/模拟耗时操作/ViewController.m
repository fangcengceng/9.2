//
//  ViewController.m
//  模拟耗时操作
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
    
    }
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [self timeconsumer];
    //解决耗时操作，将操作添加到子线程中去,解决的不是时间长短的问题，而是解决卡死UI界面，界面不能再进行操作的问题；
}
#pragma  解决UI卡顿的方法的三种方法
-(void)resolvedemo3{
    // 对象方法
    NSThread *newThread = [[NSThread alloc] initWithTarget:self selector:@selector(timeconsumer) object:nil];
    [newThread start];
}
-(void)resolvedemo2{
    //分类的对象方法
    [[NSThread alloc] performSelectorInBackground:@selector(timeconsumer) withObject:nil];
}
-(void)resolvedemo1{
    //类方法
    [ NSThread  detachNewThreadSelector:@selector(timeconsumer) toTarget:self withObject:nil];
}
-(void)timeconsumer{
    //NSTimeInterval 是doubler类型的别名
    NSTimeInterval start = CACurrentMediaTime();
    for(NSInteger i = 0; i<10000; i++){
        NSLog(@"xxx");
    }
    double end = CACurrentMediaTime() - start;
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"%f",end);
    
}
@end
