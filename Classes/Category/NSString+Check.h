//
//  NSString+Check.h
//  PJ_b2b
//
//  Created by wushengran on 18/3/21.
//  Copyright © 2018年 dq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)
- (BOOL)isValidatePhone;
- (BOOL)isValidatePwd;
- (BOOL)isValidateName;
- (BOOL)isValidateIDNum;
- (BOOL)isValidateEmail;
- (BOOL)isValidateNum;
- (BOOL)isValidateFloatNum;
@end
