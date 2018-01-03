//
//  NSString+Check.h
//  PJ_b2b
//
//  Created by 邓琼 on 16/6/21.
//  Copyright © 2016年 dq. All rights reserved.
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
