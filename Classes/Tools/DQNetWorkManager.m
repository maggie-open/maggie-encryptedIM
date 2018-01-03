//
//  DQNetWorkManager.m
//  MaggieDating
//
//  Created by 邓琼 on 2017/11/22.
//  Copyright © 2017年 com.maggie.social.MaggieDating. All rights reserved.
//

#import "DQNetWorkManager.h"

@implementation DQNetWorkManager
/** get请求 */
+(void)sendRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)params success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30;
    //让AF接受除了JSON以外的数据类型:
    //Xcode, iOS: iPhone Operator System
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    //请求头中加token
    //    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"JWT"] forHTTPHeaderField:@"x-access-token"];
    [manager GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

/** 上传照片 */
+ (void)sendPOSTWithUrl:(NSString *)urlStr parameters:(NSDictionary *)params data:(NSData *)imgData success:(void(^)(id responseObject))successBlock failure:(void(^)(NSError *error))failureBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"JWT"] forHTTPHeaderField:@"x-access-token"];
    //请求超时时间
    manager.requestSerializer.timeoutInterval = 30;
    [manager POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //        [formData appendPartWithFormData:imgData name:name];
        [formData appendPartWithFileData:imgData name:@"imagefile" fileName:@"img.jpg" mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

/** 下载文件 */
+ (void)downloadFileWithOption:(NSDictionary *)paramDic withURL:(NSString*)url savedPath:(NSString*)savedPath downloadSuccess:(void (^)(NSString *filePath))success downloadFailure:(void (^)(NSError *error))failure {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    //        progress(1.0 * downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSString * path = [savedPath stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (error == nil) {
            success([filePath path]);
        }else{
            failure(error);
        }
    }];
    [downloadTask resume];
    
}


/** post请求 */
+(void)sendPostRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)params success:(void (^)(id))successBlock failure:(void (^)(NSError *))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", nil];
    //请求头中加token
    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"JWT"] forHTTPHeaderField:@"x-access-token"];
    [manager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
    
}
@end
