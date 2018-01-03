//
//  DQUserDefaultTool.h
//  MaggieDating
//
//  Created by 邓琼 on 2017/11/21.
//  Copyright © 2017年 com.maggie.social.MaggieDating. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const LocalPWD =@"LocalPassWord";

static NSString * const CustType =@"CustType";

@interface DQUserDefaultTool : NSObject

//保存本地密码
+ (void)saveLocalPWD:(NSString *)pwd;

//获取本地密码
+ (NSString *)getLocalPWD;

//删除本地密码
+ (void)deleteLocalPWD;

//保存用户身份
+ (void)saveCustType:(NSString *)custType;

//获取用户身份
+ (NSString *)getCustType;

//删除用户身份
+ (void)deleteCustType;

@end
