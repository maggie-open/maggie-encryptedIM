//
//  DQFMDBChatAes.h
//  MaggieDating
//
//  Created by 邓琼 on 2017/11/28.
//  Copyright © 2017年 com.maggie.social.MaggieDating. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQFMDBChatAes : NSObject

@property (nonatomic, assign)NSInteger ID;
@property (nonatomic, strong)NSString *easeMobID;
@property (nonatomic, strong)NSString *chatAesKey;
@property (nonatomic, assign)BOOL isEncrypt;


/**
 获取与当前聊天对象的会话秘钥
 @param easeMobID 当前聊天对象
 @return 会话秘钥
 */
+ (NSString *)getChatAesKeyWithEaseMobID:(NSString *)easeMobID;

/**
 保存会话秘钥
 @param chatAes 会话秘钥
 @return 插入是否成功
 */
+ (BOOL)insertUserToDB:(DQFMDBChatAes *)chatAes;

@end
