//
//  ViewController.m
//  资源共享
//
//  Created by codygao on 16/9/7.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,assign)int ticket;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ticket = 20;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSThread *t1 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicket) object:nil];
    t1.name = @"t1";
    [t1 start];
    NSThread *t2 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicket) object:nil];
    t2.name = @"t2";
    [t2 start];
}
-(void)sellTicket{

    while (YES) {
        @synchronized (self) {
            if(self.ticket >0){
                [NSThread sleepForTimeInterval:1.0];
                self.ticket--;
                NSLog(@"所属线程==%@,剩余票数==%d",[NSThread currentThread], self.ticket);
            }else{
                NSLog(@"票卖完了");
                return;
            }

        }
    }
}
@end
