//
//  UIImage+FontImage.h
//  PJ_b2b
//
//  Created by 邓琼 on 16/6/20.
//  Copyright © 2016年 dq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FontImage)
+ (UIImage*)imageWithIcon:(NSString*)iconCode inFont:(NSString*)fontName size:(NSUInteger)size color:(UIColor*)color;
@end
