//
//  AppDelegate+initVC.m
//  MaggieDating
//
//  Created by wushengran on 2017/11/21.
//  Copyright © 2017年 com.maggie.social.MaggieDating. All rights reserved.
//

#import "AppDelegate+initVC.h"
#import "DQLoginViewController.h"
#import "DQPWDViewController.h"
#import "DQBuyerMainViewController.h"
#import "JDRSAUtil.h"
#import "JDKeyChainWapper.h"
#import "DQUserDefaultTool.h"
#import "DQRSAProgressViewController.h"


@implementation AppDelegate (initVC)

- (UIViewController *)getInitViewController {
    
//    [JDKeyChainWapper deleteStringWithIdentifier:OpenSSL_certTag]; //测试代码
    
    //判断keychain中是否存在证书，不存在则去往登录页
//    NSString *cert =  [JDKeyChainWapper loadStringDataWithIdentifier:OpenSSL_certTag];
//
//    if (!cert || [cert isEqualToString:@""]) {
        return [[UINavigationController alloc]initWithRootViewController:[DQLoginViewController new]];
//    }
//    //判断是否有本地密码，存在则去往密码页
//    if ([DQUserDefaultTool getLocalPWD]) {
//        return [DQPWDViewController new];
//    }
//    //有公私钥&&无本地密码，前往认证页
//    return [DQRSAProgressViewController new];
}


@end
