//
//  catagoryModel.h
//  代码二
//
//  Created by codygao on 16/9/6.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface catagoryModel : NSObject
@property(nonatomic,copy) NSString *category_name;
@property(nonatomic,copy)NSString *category_picurl;
+(instancetype)catagoryWithDic:(NSDictionary *)dic;
@end
