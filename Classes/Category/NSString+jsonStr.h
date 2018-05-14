//
//  NSString+jsonStr.h
//  PJ_b2b
//
//  Created by wushengran on 18/3/24.
//  Copyright © 2018年 dq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (jsonStr)
- (id)JSONValue;
+ (NSString*)JSONStringWith:(NSObject *)data;
@end
