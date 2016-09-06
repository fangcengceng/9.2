//
//  catagoryModel.m
//  代码二
//
//  Created by codygao on 16/9/6.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "catagoryModel.h"

@implementation catagoryModel
+(instancetype)catagoryWithDic:(NSDictionary *)dic{
    catagoryModel *catagory = [[catagoryModel alloc] init];
    [catagory setValuesForKeysWithDictionary:dic];
    return catagory;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
