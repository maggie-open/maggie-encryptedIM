//
//  NSDate+localDate.m
//  PM
//
//  Created by wushengran on 2018/2/8.
//  Copyright © 2018年 dq. All rights reserved.
//

#import "NSDate+localDate.h"

@implementation NSDate (localDate)
- (NSDate *)local {
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger integer = [zone secondsFromGMTForDate:[NSDate date]];
    NSDate *localDate = [[NSDate date] dateByAddingTimeInterval:integer];
    return localDate;
}
@end
