//
//  FASButtonOne.m
//  FASFamouseList
//
//  Created by codygao on 16/9/7.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "FASButtonOne.h"
#import "NSAttributedString+CZAdditon.h"
#import "Masonry.h"

@implementation FASButtonOne

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    [self addbuttons:@"gt" title:@"肿瘤" tag:1];
    [self addbuttons:@"gy" title:@"心血管" tag:2];
    [self addbuttons:@"sj" title:@"神经科" tag:3];
}
-(void)addbuttons:(NSString *)imageName title:(NSString*)title tag:(int)tag{
    NSAttributedString *str = [NSAttributedString cz_imageTextWithImage:[UIImage imageNamed:imageName] imageWH:20 title:title fontSize:15 titleColor:[UIColor blackColor] spacing:4];
    UIButton *button = [[UIButton alloc] init];
    [button setAttributedTitle:str forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.numberOfLines = 0 ;
    [button sizeToFit];
    [self addSubview:button];
    button.tag = tag;
    [button addTarget:self action:@selector(clickToDetail:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)clickToDetail:(UIButton*)sender{
    NSLog(@"XXXX");
    
    
}
- (void)layoutSubviews{
    //一定要调用父类的方法
    [super layoutSubviews];
    CGFloat margin = (self.frame.size.width - self.subviews[0].frame.size.width * 3)/4;
    
    //需要把个数减1
    for (NSInteger i = 0; i<self.subviews.count - 1; i++) {
        //拿到当前按钮
        UIButton *button = self.subviews[i];
        //拿到下一个按钮
        UIButton *nextButton = self.subviews[i+1];
        
        if (i == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self).offset(margin);
            }];
        }
        
        [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(button.mas_right).offset(margin);
            make.centerY.equalTo(self);
        }];
    }
    
}


@end