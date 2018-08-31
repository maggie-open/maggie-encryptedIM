//
//  DQNetWorkManager.h
//  MaggieDating
//
//  Created by 邓琼 on 2017/11/22.
//  Copyright © 2017年 com.maggie.social.MaggieDating. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQNetWorkManager : NSObject
/** get请求 */
+(void) sendRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)params success:(void(^)(id responseObject))successBlock failure:(void(^)(NSError *error))failureBlock;

/** post请求 */
+(void)sendPostRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)params success:(void (^)(id responseObject))successBlock failure:(void (^)(NSError *error))failureBlock;

/** 上传照片 */
+ (void)sendPOSTWithUrl:(NSString *)urlStr parameters:(NSDictionary *)params data:(NSData *)imgData  success:(void(^)(id responseObject))successBlock failure:(void(^)(NSError *error))failureBlock;

/** 下载文件 */
+ (void)downloadFileWithOption:(NSDictionary *)paramDic withURL:(NSString*)url savedPath:(NSString*)savedPath downloadSuccess:(void (^)(NSString *filePath))success downloadFailure:(void (^)(NSError *error))failure ;

@end