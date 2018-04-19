//
//  FMDatabaseQueueManager.m
//  FMDataPractice
//
//  Created by codygao on 16/9/5.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "FMDatabaseQueueManager.h"

@implementation FMDatabaseQueueManager
+(instancetype)sharedManager{
    static FMDatabaseQueueManager* instace;
    dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       //创建数据库
       NSString *DBPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"HM02.db"];
       instace = [FMDatabaseQueueManager databaseQueueWithPath:DBPath];
       //创建数据库表
       [instace  inDatabase:^(FMDatabase *db) {
           NSString *creatSQL = @"create table if not exists t_person(id integer primary key not null,name text,age integer);";
           [db executeUpdate:creatSQL];
       }];
   });
    return instace;
}
@end
