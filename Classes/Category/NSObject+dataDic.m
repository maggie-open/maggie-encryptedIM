//
//  NSObject+dataDic.m
//  CreditFactory
//
//  Created by 邓琼 on 2018/3/24.
//  Copyright © 2018年 dq. All rights reserved.
//

#import "NSObject+dataDic.h"

@implementation NSObject (dataDic)
- (NSString *)dataDicValueAtKey:(NSString *)key {
    NSString *value = nil;
    if ([self isKindOfClass:[NSArray class]]) {
        for (id obj in (NSArray *)self) {
            if ([obj[@"key"] isEqualToString:key]) {
                value = obj[@"value"];
            }
        }

    }
    return value;
}
@end
