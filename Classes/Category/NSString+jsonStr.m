//
//  NSString+jsonStr.m
//  PJ_b2b
//
//  Created by 邓琼 on 16/6/24.
//  Copyright © 2016年 dq. All rights reserved.
//

#import "NSString+jsonStr.h"

@implementation NSString (jsonStr)
- (id)JSONValue {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error){
        return nil;
    }
    return result;
}
+ (NSString*)JSONStringWith:(NSObject *)data {
    NSError *error = nil;
    NSData *result = [NSJSONSerialization dataWithJSONObject:data
                                                options:kNilOptions error:&error];
    if (error){
        return nil;
    }
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}
@end
