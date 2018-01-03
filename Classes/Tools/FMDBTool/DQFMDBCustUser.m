//
//  DQFMDBCustUser.m
//  MaggieDating
//
//  Created by 邓琼 on 2017/11/24.
//  Copyright © 2017年 com.maggie.social.MaggieDating. All rights reserved.
//

#import "DQFMDBCustUser.h"
#import "DQFMDBTool.h"

@implementation DQFMDBCustUser

+ (NSArray *)getAllUsersFromDB {
    FMDatabase *database = [DQFMDBTool sharedDatabase];
    FMResultSet *resultSet = [database executeQuery:@"select * from cust_user"];
    NSMutableArray *mutableArray = [NSMutableArray array];
    while ([resultSet next]) {
        DQFMDBCustUser *user = [self new];
        user.ID = [resultSet intForColumn:@"id"];
        user.mobile = [resultSet stringForColumn:@"moblie"];
        user.custType = [resultSet stringForColumn:@"custType"];
        user.hasLocalPwd = [resultSet intForColumn:@"hasLocalPwd"];
        user.isActivity = [resultSet intForColumn:@"isActivity"];
        [mutableArray insertObject:user atIndex:0];
    }
    [database close];
    return [mutableArray copy];
}

+ (BOOL)insertUserToDB:(DQFMDBCustUser *)user {
    FMDatabase *database = [DQFMDBTool sharedDatabase];
    //将活跃用户isActivity改为0
    BOOL isSuccess1 = [database executeUpdate:@"update cust_user set isActivity = 0 where isActivity = 1"];
    //查找用户是否存在，存在则将isActivity改为1，不存在则插入
    FMResultSet *resultSet = [database executeQuery:@"select * from cust_user where mobile = '%@'", user.mobile];
    BOOL isSuccess2 = 0;
    if ([resultSet next]) {
        isSuccess2 = [database executeUpdate:@"update cust_user set isActivity = 1 where mobile = '%@'", user.mobile];
    } else {
        //插入新登录用户
        NSString *str = [NSString stringWithFormat:@"insert into cust_user (mobile, custType, hasLocalPwd, isActivity) values ('%@', '%@', '%d', '1')", user.mobile, user.custType, user.hasLocalPwd];
        isSuccess2 = [database executeUpdateWithFormat: str, nil];
    }
    [database close];
    return isSuccess1&& isSuccess2;
}

+ (DQFMDBCustUser *)getActivityUser {
    FMDatabase *database = [DQFMDBTool sharedDatabase];
    FMResultSet *resultSet = [database executeQuery:@"select * from cust_user where isActivity = 1"];
    DQFMDBCustUser *user = nil;
    if ([resultSet next]) {
        user = [self new];
        user.ID = [resultSet intForColumn:@"id"];
        user.mobile = [resultSet stringForColumn:@"moblie"];
        user.custType = [resultSet stringForColumn:@"custType"];
        user.hasLocalPwd = [resultSet intForColumn:@"hasLocalPwd"];
        user.isActivity = [resultSet intForColumn:@"isActivity"];
    }
    [database close];
    return user;
}

+ (BOOL)removeUser:(NSInteger)ID {
    FMDatabase *database = [DQFMDBTool sharedDatabase];
    NSString *str = [NSString stringWithFormat:@"delete from cust_user where id = '%ld' ", ID];
    BOOL isSuccess = [database executeUpdateWithFormat:str, nil];
    [database close];
    return isSuccess;
}

@end
