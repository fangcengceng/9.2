//
//  FASButtonView.m
//  FASFamouseList
//
//  Created by codygao on 16/9/8.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "FASButtonView.h"
#import "NSAttributedString+CZAdditon.h"
#import "Masonry.h"
#define kColum 3
@interface FASButtonView()
@property(nonatomic,weak) UIButton *button;
@end
@implementation FASButtonView
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
    [self addbuttons:@"xy" title:@"骨科" tag:4];
    [self addbuttons:@"xyg" title:@"血液科" tag:5];
    [self addbuttons:@"zl" title:@"更多" tag:6];
    
  
}
-(void)addbuttons:(NSString *)imageName title:(NSString*)title tag:(int)tag{
    
    NSAttributedString *str = [NSAttributedString cz_imageTextWithImage:[UIImage imageNamed:imageName] imageWH:20 title:title fontSize:15 titleColor:[UIColor blackColor] spacing:7];
    UIButton *button = [[UIButton alloc] init];
    [button setAttributedTitle:str forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.numberOfLines = 0 ;
    [button sizeToFit];
    button.tag = tag;
    [button addTarget:self action:@selector(clickToDetail:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    self.button = button;
}
-(void)clickToDetail:(UIButton*)sender{
    NSLog(@"%ld",sender.tag);
    
}
-(void)layoutSubviews{
    [super layoutSubviews];

    for (NSInteger i = 0; i<self.subviews.count; i++) {
        float buttonH = self.bounds.size.height*0.5;
          NSInteger Row = i/kColum;
        float buttonW = self.bounds.size.width/kColum;
        NSInteger currentColum = i % kColum;
        //拿到当前按钮
        UIButton *button = self.subviews[i];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(Row *buttonH);
                make.left.equalTo(self).offset(currentColum*buttonW);
                make.width.mas_equalTo(buttonW);
                make.height.mas_equalTo(buttonH);
            }];
        }
}
@end
