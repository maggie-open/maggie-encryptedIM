//
//  UIImage+FontImage.h
//  PJ_b2b
//
//  Created by wushengran on 18/3/20.
//  Copyright © 2018年 dq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FontImage)
+ (UIImage*)imageWithIcon:(NSString*)iconCode inFont:(NSString*)fontName size:(NSUInteger)size color:(UIColor*)color;
@end
