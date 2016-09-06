//
//  CATegoryViewController.m
//  代码二
//
//  Created by codygao on 16/9/6.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "CATegoryViewController.h"
#import "AFNetworking.h"
#import "catagoryModel.h"
#import "UIImageView+WebCache.h"
#import "WEBViewController.h"

@interface CATegoryViewController ()<UITableViewDataSource,UITableViewDelegate>
@end

@implementation CATegoryViewController{
    NSArray<catagoryModel*> *_catagoryList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
}
-(void)loadData{
    [[[NSURLSession sharedSession ] dataTaskWithURL:[NSURL URLWithString:@"http://app.nuomi.com/naserver/home/homepage?appid=ios&bduss=&channel=com_dot_apple&cityid=100010000&cuid=11a2e62839f7bed05437dcb826be61a0c47a515c&device=iPhone&ha=5&lbsidfa=ACAF9226-F987-417B-A708-C95D482A732D&location=39.989360%2C116.324490&logpage=Home&net=unknown&os=8.2&sheight=1334&sign=40c974d176568886ad0e72516645e23f&swidth=750&terminal_type=ios&timestamp=1442906717563&tn=ios&uuid=11a2e62839f7bed05437dcb826be61a0c47a515c&v=5.13.0"
] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil & data !=nil){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options: 0 error:0];
            
            NSDictionary *datadic = dic[@"data"];
            NSArray *Arr = datadic[@"category"];
            //字典转模型；
            NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:Arr.count];
            [Arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                catagoryModel  *category = [catagoryModel catagoryWithDic:obj];
                [tempArr addObject:category];
            }];
            _catagoryList = [[NSArray alloc] init];
            _catagoryList  = tempArr.copy;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
        }else{
            NSLog(@"%@",error);
        }
        
    }] resume];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _catagoryList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tabelviewcell" forIndexPath:indexPath];
    catagoryModel *model = _catagoryList[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.category_picurl]];
    cell.textLabel.text  = model.category_name;
    return cell;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    WEBViewController *webview = [[WEBViewController alloc] init];
    [self.navigationController pushViewController:webview animated:YES];
    webview.urlName =@"http://t10.nuomi.com/webapp/na/topten?from=fr_na_t10tab&sizeLimit=8&version=2&needstorecard=1&areaId=100010000&location=39.989430,116.324470&bn_aid=ios&bn_v=5.13.0&bn_chn=com_dot_apple";
}

@end
