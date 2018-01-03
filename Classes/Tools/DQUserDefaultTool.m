//
//  DQUserDefaultTool.m
//  MaggieDating
//
//  Created by 邓琼 on 2017/11/21.
//  Copyright © 2017年 com.maggie.social.MaggieDating. All rights reserved.
//

#import "DQUserDefaultTool.h"

@implementation DQUserDefaultTool

+ (void)saveLocalPWD:(NSString *)pwd {
    [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:LocalPWD];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getLocalPWD {
    return [[NSUserDefaults standardUserDefaults] objectForKey:LocalPWD];
}

+ (void)deleteLocalPWD {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:LocalPWD];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveCustType:(NSString *)custType {
    [[NSUserDefaults standardUserDefaults] setObject:custType forKey:CustType];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getCustType {
    return [[NSUserDefaults standardUserDefaults] objectForKey:CustType];
}

+ (void)deleteCustType {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:CustType];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
