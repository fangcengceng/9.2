//
//  ViewController.m
//  self 和target 的关系
//
//  Created by codygao on 16/9/6.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "person.h"

@interface ViewController ()
@property(nonatomic,strong)person *p;
@end

@implementation ViewController
-(person*)p{
    if(_p == nil){
        _p = [[person alloc ] init];
    }
    return _p;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self nsthreaddemo1];
    [self nsthreaddemo2];
}
-(void)nsthreaddemo1{
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self.p withObject:@"这是一个参数值，类比通知"];
}
-(void)nsthreaddemo2{
    [[[NSThread alloc] initWithTarget:self selector:@selector(deom2:) object:@"这是在本类中调用这个方法"] start];
}
-(void)deom2:(id )paragma{
    NSLog(@"%@",paragma);
}
@end
