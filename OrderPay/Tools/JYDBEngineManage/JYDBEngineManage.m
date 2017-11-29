//
//  JYDBEngineManage.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/25.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "JYDBEngineManage.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabaseQueue.h"
#import "CMGlobalDef.h"
#import "CMFile.h"

static FMDatabaseQueue *__JYdbQueue;

@implementation JYDBEngineManage
+ (NSString *)databasePath
{
    NSString* dbPath = [NSString stringWithFormat:@"%@/%@",[CMFile documentPath],KCommonFile];
    
    if (![CMFile adjustFileAtPath:dbPath]){
        [CMFile createDirectoryAtPath:dbPath];
    }
    return [NSString stringWithFormat:@"%@/%@",dbPath,KCommonName];
}

+ (void)CR_DB_Init
{
    NSString* fullPath = [self databasePath];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!__JYdbQueue){
            __JYdbQueue = [FMDatabaseQueue databaseQueueWithPath:fullPath];
        }
    });
    [__JYdbQueue inDatabase:^(FMDatabase *db) {
        [db setKey:KDatabaseSecretKey];
    }];
    [__JYdbQueue inDatabase:^(FMDatabase *db){
        //draft
        NSString *user_SQL = @"CREATE TABLE IF NOT EXISTS tb_user(id INTEGER PRIMARY KEY AUTOINCREMENT,login_userid TEXT,\
        login_content TEXT);";
        NSArray* array = @[user_SQL];
        for(NSString* strSQL in array) {
            [db executeUpdate:strSQL];
             NSLog(@"%d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
    }];
}

@end
