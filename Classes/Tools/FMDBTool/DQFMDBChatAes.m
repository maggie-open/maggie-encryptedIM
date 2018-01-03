//
//  DQFMDBChatAes.m
//  MaggieDating
//
//  Created by 邓琼 on 2017/11/28.
//  Copyright © 2017年 com.maggie.social.MaggieDating. All rights reserved.
//

#import "DQFMDBChatAes.h"
#import "DQFMDBTool.h"

@implementation DQFMDBChatAes

+ (NSString *)getChatAesKeyWithEaseMobID:(NSString *)easeMobID {
    FMDatabase *database = [DQFMDBTool sharedDatabase];
    NSString *str = [NSString stringWithFormat:@"select * from chat_aes where easeMobID = '%@'", easeMobID];
    FMResultSet *resultSet = [database executeQuery:str];
    NSString *aesKey = nil;
    while ([resultSet next]) {
        aesKey = [resultSet stringForColumn:@"chatAesKey"];
    }
    [database close];
    return aesKey;
}

+ (BOOL)insertUserToDB:(DQFMDBChatAes *)chatAes {
    FMDatabase *database = [DQFMDBTool sharedDatabase];
    //查找秘钥是否存在，存在则修改，不存在则插入
    FMResultSet *resultSet = [database executeQuery:@"select * from chat_aes where easeMobID = '%@'", chatAes.easeMobID];
    BOOL isSuccess = NO;
    if ([resultSet next]) {
        isSuccess = [database executeUpdate:@"update chat_aes set chatAesKey = '%@' where easeMobID = '%@'", chatAes.chatAesKey, chatAes.easeMobID];
    } else {
        NSString *str = [NSString stringWithFormat:@"insert into chat_aes (easeMobID, chatAesKey, isEncrypt) values ('%@', '%@', 1)", chatAes.easeMobID, chatAes.chatAesKey];
        isSuccess = [database executeUpdateWithFormat: str, nil];
    }
    [database close];
    return isSuccess;
}

@end
