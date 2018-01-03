//
//  NSString+md5.m
//  PJ_b2b
//
//  Created by 邓琼 on 16/6/21.
//  Copyright © 2016年 dq. All rights reserved.
//

#import "NSString+md5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (md5)

- (NSString *)md5Str {
    NSString *str1 =  [self stringByReplacingOccurrencesOfString:@"0" withString:@"~"];
    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"1" withString:@"$"];
    NSString *str3 = [str2 stringByReplacingOccurrencesOfString:@"2" withString:@"!"];
    NSString *str4 = [str3 stringByReplacingOccurrencesOfString:@"3" withString:@"@"];
    NSString *str5 = [str4 stringByReplacingOccurrencesOfString:@"4" withString:@":"];
    NSString *str6 = [str5 stringByReplacingOccurrencesOfString:@"5" withString:@"]"];
    NSString *str7 = [str6 stringByReplacingOccurrencesOfString:@"6" withString:@"["];
    NSString *str8 = [str7 stringByReplacingOccurrencesOfString:@"7" withString:@"{"];
    NSString *str9 = [str8 stringByReplacingOccurrencesOfString:@"8" withString:@"}"];
    NSString *str = [str9 stringByReplacingOccurrencesOfString:@"9" withString:@"`"];
    NSString *myStr = @"QmVpamluZyBDaGluYSBGaW5hbmNlIENsb3VkIElubm92YXRpb24gU29mdHdhcmUgQ28uLCBMdGQu";
    NSString *totalStr = [myStr substringWithRange:NSMakeRange(0, myStr.length-str.length)];
    NSString *newStr = [NSString stringWithFormat:@"%@%@", totalStr, str];
    
    const char *cStr = [newStr UTF8String];
    unsigned char result[16];
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    return [[NSString stringWithFormat:
                @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                result[0], result[1], result[2], result[3],
                result[4], result[5], result[6], result[7],
                result[8], result[9], result[10], result[11],
                result[12], result[13], result[14], result[15]
                ] uppercaseString];
}
@end
