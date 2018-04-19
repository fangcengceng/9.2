//
//  ViewController.m
//  CYCleViews
//
//  Created by codygao on 16/9/5.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "NEWcycle.h"
#import "Masonry.h"

@interface ViewController (){
    NSArray *_cycleList;
}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _cycleList = [[NSArray alloc] init];
    [self loadcycleList];
    NEWcycle *cycleView = [[NEWcycle alloc] init];
    [self.view addSubview:cycleView];
    cycleView.cycleList = _cycleList;
    [cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
}
-(void)loadcycleList{
    //把资源路径中的资源加载成URL
      NSMutableArray *tempArray = [NSMutableArray array];
    for(NSInteger i = 0; i<5; i++){
    NSURL *URL = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"Home_Scroll_%02zd.jpg",i+1] withExtension:nil];
    //把URL转化为二进制数据
    NSData *data = [NSData dataWithContentsOfURL:URL];
        UIImage *image = [UIImage imageWithData:data];
        [tempArray addObject:image];
    }
    
    _cycleList = tempArray.copy;
}

@end
