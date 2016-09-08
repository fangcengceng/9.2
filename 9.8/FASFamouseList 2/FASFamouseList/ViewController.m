//
//  ViewController.m
//  FASFamouseList
//
//  Created by codygao on 16/9/7.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "FASButtonView.h"
#import "FASFamouseCell.h"
static NSString *famouseDoctorCell =@"famouseDoctorCell";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDemoUI];
}
#pragma  界面搭建
-(void)setupDemoUI{
  
    //轮播器试图；
    UIView *cycleView = [[UIView alloc] init];
    cycleView.backgroundColor = [UIColor redColor];
    [self.view addSubview:cycleView];
    
    //button试图
    FASButtonView *buttonView = [[FASButtonView alloc] init];
    buttonView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:buttonView];
    
    //tableview 视图
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    tableview.dataSource = self;
    tableview.delegate = self;
    [tableview registerClass:[FASFamouseCell class] forCellReuseIdentifier:famouseDoctorCell];
    tableview.estimatedRowHeight = 300;
    tableview.rowHeight = UITableViewAutomaticDimension;

    
 //搭建轮播器视图约束
    [cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(100);
        
    }];
   //搭建按钮视图约束
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(cycleView.mas_bottom);
        make.height.mas_equalTo(100);
    }];
    //搭建tableview视图约束
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(buttonView.mas_bottom);
        
    }];
}
#pragma  -----tableviewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FASFamouseCell *cell = [tableView dequeueReusableCellWithIdentifier:famouseDoctorCell forIndexPath:indexPath];

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    [tableView addSubview:label];
    label.font = [UIFont systemFontOfSize:20];
    label.text = @"名医推荐";
    return label;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
}
@end
