//
//  FMDatabaseQueueManager.h
//  FMDataPractice
//
//  Created by codygao on 16/9/5.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <FMDB/FMDB.h>

@interface FMDatabaseQueueManager : FMDatabaseQueue
+(instancetype)sharedManager;
@end
