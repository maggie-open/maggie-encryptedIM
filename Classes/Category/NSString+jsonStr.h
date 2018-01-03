//
//  NSString+jsonStr.h
//  PJ_b2b
//
//  Created by 邓琼 on 16/6/24.
//  Copyright © 2016年 dq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (jsonStr)
- (id)JSONValue;
+ (NSString*)JSONStringWith:(NSObject *)data;
@end
