//
//  ViewController.m
//  FMDataPractice
//
//  Created by codygao on 16/9/5.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabaseQueueManager.h"

@interface ViewController ()

@end

@implementation ViewController{
    FMDatabaseQueueManager *_manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager  = [FMDatabaseQueueManager sharedManager];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self insert];
}
#pragma mark - 事务
- (void)shiwu
{
    double start = CACurrentMediaTime();
    
    // 新增SQL
    NSString *insertSQL = @"insert into t_person(name,age) values(?,?);";
    
    // 开启事务
    [_manager inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        for (NSInteger i = 0; i<1000; i++) {
            BOOL isOK = [db executeUpdate:insertSQL,@"雷鹏飞",@(100)];
            // 提示 : 一旦有一条数据错误,就回滚
            // 提示 : 笔记里面这个判断写错啦!!!以课堂代码为准
            if (!isOK) {
                // 回滚快照
                *rollback = YES;
                // 非常重要
                break;
            }
        }
    }];
    
    // 0.006041
    NSLog(@"%f",CACurrentMediaTime() - start);
}

#pragma mark - 查询记录
- (void)query
{
    // 定义查询的语句
    NSString *querySQL = @"select name,age from t_person";
    // 执行查询的语句
    [_manager inDatabase:^(FMDatabase *db) {
        
        // 拿到查询之后的结果集
        FMResultSet *resultSet = [db executeQuery:querySQL];
        // 循环遍历结果集 : 会自动检测下一条记录有没有
        while ([resultSet next]) {
            // 逐条取出记录
            // 取name
            NSString *name = [resultSet stringForColumn:@"name"];
            // 取age
            int age = [resultSet intForColumn:@"age"];
            
            NSLog(@"%@ -- %d",name,age);
            
            // 提示 : 循环的取出记录,赋值给模型的属性,把模型添加到数据组,生成模型数组
        }
    }];
}

#pragma mark - 删除记录
- (void)delete
{
    // 定义删除SQL
    NSString *deleteSQL = @"delete from t_person where id = ?";
    // 执行删除SQL
    [_manager inDatabase:^(FMDatabase *db) {
        BOOL isOK = [db executeUpdate:deleteSQL,@(5)];
        if (isOK) {
            NSLog(@"删除记录成功");
        } else {
            NSLog(@"删除记录失败");
        }
    }];
}

#pragma mark - 修改记录
- (void)update
{
    // 定义修改SQL
    NSString *updateSQL = @"update t_person set name = ? where id = ?";
    
    // 执行修改SQL
    [_manager inDatabase:^(FMDatabase *db) {
        BOOL isOK = [db executeUpdate:updateSQL,@"夏宁",@(6)];
        if (isOK) {
            NSLog(@"修改记录成功");
            
            // 获取影响的行数
            NSLog(@"影响的行数 %d",db.changes);
            
        } else {
            NSLog(@"修改记录失败");
        }
    }];
}

#pragma mark - 新增记录

/// 预编译
- (void)insert01
{
    NSString *name = @"xxx',12334);";
    
    // 定义新增SQL : 商业代码,可以换钱
    NSString *insertSQL = @"insert into t_person(name,age) values(?,?);";
    
    // 执行新增SQL : Block会把数据库句柄,自动的回调出去供外界使用
    // inDatabase : 自动的在串行队列里面同步的调度db执行SQL
    [_manager inDatabase:^(FMDatabase *db) {
        
        BOOL isOK = [db executeUpdate:insertSQL,name,@(23)];
        if (isOK) {
            NSLog(@"新增记录成功");
        } else {
            NSLog(@"新增记录失败");
        }
        
        // 获取自增长的主键
        NSLog(@"主键 %lld",db.lastInsertRowId);
    }];
}

-(void)insert{
    NSString *name = @"xx";
    //定义新增SQL
    NSString *insertSQL = [NSString stringWithFormat:@"insert into t_person(name,age) values('%@',19)",name];
    [_manager inDatabase:^(FMDatabase *db) {
        BOOL isOK = [db executeUpdate:insertSQL];
        if(isOK){
            NSLog(@"新增记录成功");
        }else{
            NSLog(@"新增记录失败");
        }
        NSLog(@"主键== %lld",db.lastInsertRowId);
        
    }];
}
@end
