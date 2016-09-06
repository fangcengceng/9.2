//
//  HMNewController.m
//  easyNetNews
//
//  Created by codygao on 16/9/2.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "HMNewController.h"
#import "networkingTool.h"
#import "HMNewsModel.h"
#import "hmnewCell.h"
#import "NEWcycle.h"
#import "CYClelayout.h"
#import "Masonry.h"

@interface HMNewController ()<UITableViewDataSource,UITabBarDelegate>

@end

@implementation HMNewController{
    NSArray<HMNewsModel*> *_newList;
    NSArray<UIImage*> *_cycleList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     _cycleList = [[NSArray alloc] init];
      [self loadcycleList];
}
-(void)setUrlName:(NSString *)urlName{
    _urlName = urlName;
  //拿到地址提取发送网路请求
    [self loadNewData:urlName];
}
-(void)loadNewData:(NSString *)urlname{
    networkingTool *nettool = [networkingTool sharednetToll];
   [nettool GETwithRequestUrl:urlname successful:^(NSDictionary* responsobjec) {
       //获取字典的第一个key值
       NSString *key = responsobjec.keyEnumerator.nextObject;
       NSArray *newlist = responsobjec[key];
       NSMutableArray *temparray = [NSMutableArray arrayWithCapacity:newlist.count];
      [newlist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
          HMNewsModel *model = [HMNewsModel hmnewsWithDic:obj];
          [temparray addObject:model];
        
      }];
      _newList =temparray.copy;
       //刷新UI
       [self.tableView reloadData];
       
   } fail:^(NSError *error) {
       NSLog(@"%@",error);
   }];
    
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _newList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier;
    HMNewsModel *model = _newList[indexPath.row];
    if(model.imgType == YES){
        identifier = @"hmbigcell";
    }else if (model.imgextra.count == 2){
        identifier = @"extralcell";
    }else{
        identifier =  @"hmnewscell";
    }
    
    hmnewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
   
    cell.newsmodel = model;    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellH;
    HMNewsModel *newsModel = _newList[indexPath.row];
    if(newsModel.imgType){
        cellH =180;
    }else if(newsModel.imgextra.count == 2){
        cellH = 130;
    }else{
        cellH= 80;
    }
    return cellH;
}
#pragma mark 加载轮播器
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  
    NEWcycle *cycleView = [[NEWcycle alloc] init];
    [self.view addSubview:cycleView];
    cycleView.cycleList = _cycleList;
//    [cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(self.view);
//        make.height.mas_equalTo(100);
//    }];
    return cycleView;
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
