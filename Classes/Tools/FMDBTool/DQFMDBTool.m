//
//  DQFMDBTool.m
//  MaggieDating
//
//  Created by 邓琼 on 2017/11/24.
//  Copyright © 2017年 com.maggie.social.MaggieDating. All rights reserved.
//

#import "DQFMDBTool.h"

@implementation DQFMDBTool

+ (FMDatabase *)sharedDatabase {
    //使用GCD的一次性任务实现两个逻辑
    static FMDatabase *database = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //创建数据库（xxx/Documents/UserData/fmdb.db）
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"MaggieUser.db"];
        DLog(@"数据库文件存放位置：%@", filePath);
        database = [FMDatabase databaseWithPath:filePath]; //不存在则创建
        //创建表
        if ([database open]) {  //打开数据库
            BOOL isSuccess = [database executeUpdate:@"create table if not exists cust_user (id integer primary key, mobile text, custType text, hasLocalPwd integer, isActivity integer)"];
            if (!isSuccess) {
                DLog(@"创建cust_user表失败: %@", database.lastError);
            }
            isSuccess = [database executeUpdate:@"create table if not exists chat_aes (id integer primary key, easeMobID text, chatAesKey text, isEncrypt integer)"];
            if (!isSuccess) {
                DLog(@"创建chat_aes表失败: %@", database.lastError);
            }
        }
    });
//    dispatch_once(&onceToken, ^{
//        //移动数据库文件到/Documents/sqlite.db
//        NSString *atPath = [[NSBundle mainBundle] pathForResource:@"MaggieUser.db" ofType:nil];
//        NSString *toPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"MaggieUser.db"];
//        NSError *error = nil;
//        if (![[NSFileManager defaultManager] fileExistsAtPath:toPath]) {
//            [[NSFileManager defaultManager] copyItemAtPath:atPath toPath:toPath error:&error];
//        }
//        if (!error) {
//            database = [FMDatabase databaseWithPath:toPath];
//        }
//    });
    [database open];
    return database;
}

@end
