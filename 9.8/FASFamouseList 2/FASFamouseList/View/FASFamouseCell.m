//
//  FASFamouseCell.m
//  FASFamouseList
//
//  Created by codygao on 16/9/8.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "FASFamouseCell.h"
#import "Masonry.h"

@implementation FASFamouseCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupUI];
    }
    return  self;
}
- (void)setupUI{
    //图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor  = [UIColor redColor];
    [self.contentView addSubview:imageView];
    //姓名标签
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"回龙观安东尼";
    [self.contentView addSubview:nameLabel];
    //级别标签
    UILabel *levelLabel = [[UILabel alloc] init];
    levelLabel.text = @"主任医生";
    levelLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:levelLabel];
    //科室标签
    UILabel *classLabel = [[UILabel alloc] init];
    classLabel.text = @"胃病";
    [self.contentView addSubview:classLabel];
    
    //所属医院标签
    UILabel *hospitalLabel = [[UILabel alloc] init];
    hospitalLabel.text = @"北京市第一人民医院";
    levelLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:hospitalLabel];
    
    //详情标签
    UILabel *detalilLabel = [[UILabel alloc] init];
    detalilLabel.text = @"善于卡位，人送外号回龙管龙猫你的额沙龙东方速度快解放";
    detalilLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:detalilLabel];
    
    //推荐标签
    UILabel *praiseLabel = [[UILabel alloc] init];
    praiseLabel.text = @"推荐指数";
    praiseLabel.textColor = [UIColor redColor];
    praiseLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:praiseLabel];
    
    //评分标签
    UILabel *scoreLabel = [[UILabel alloc] init];
    scoreLabel.text = @"100";
    scoreLabel.textColor = [UIColor redColor];

    [self.contentView addSubview:scoreLabel];
    
    //约束条件
    [imageView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(8);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView);
        make.left.equalTo(imageView.mas_right).offset(3);
        make.width.mas_equalTo(100);
    }];
   
    [levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom);
        make.left.equalTo(nameLabel);
        make.width.mas_equalTo(70);
    }];
    [classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(levelLabel);
        make.left.equalTo(levelLabel.mas_right);
        make.width.mas_equalTo(100);
    }];
    
    [hospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.top.equalTo(levelLabel.mas_bottom);
        make.width.mas_equalTo(200);
    }];
    
    [detalilLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(imageView);
        make.left.equalTo(nameLabel);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    
    [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel);
        make.centerX.equalTo(praiseLabel.mas_centerX);
//        make.right.equalTo(self.contentView).offset(-20);
        make.width.mas_equalTo(80);
    }];
    
    [praiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.equalTo(self.contentView);
//        make.centerX.equalTo(scoreLabel);
        make.top.equalTo(scoreLabel.mas_bottom);
        make.width.mas_equalTo(80);
        
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self);
        make.bottom.equalTo(detalilLabel.mas_bottom).offset(10);
        
    }];
}
@end
