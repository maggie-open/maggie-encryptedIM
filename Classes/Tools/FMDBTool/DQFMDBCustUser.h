//
//  DQFMDBCustUser.h
//  MaggieDating
//
//  Created by 邓琼 on 2017/11/24.
//  Copyright © 2017年 com.maggie.social.MaggieDating. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQFMDBCustUser : NSObject

@property (nonatomic, assign)NSInteger ID;
@property (nonatomic, strong)NSString *mobile;
@property (nonatomic, strong)NSString *custType;
@property (nonatomic, assign)BOOL hasLocalPwd;
@property (nonatomic, assign)BOOL isActivity;


+ (NSArray *)getAllUsersFromDB;
+ (BOOL)insertUserToDB:(DQFMDBCustUser *)user;
+ (BOOL)removeUser:(NSInteger)ID;

@end
