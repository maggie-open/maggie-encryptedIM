//
//  NSString+jsonStr.m
//  PJ_b2b
//
//  Created by wushengran on 18/3/24.
//  Copyright © 2018年 dq. All rights reserved.
//

#import "NSString+jsonStr.h"

+ (NSString*)JSONStringWith:(NSObject *)data {
    NSError *error = nil;
    NSData *result = [NSJSONSerialization dataWithJSONObject:data
                                                options:kNilOptions error:&error];
    if (error){
        return nil;
    }
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

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

@end
