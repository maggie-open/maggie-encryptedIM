//
//  UIView+datePicker.h
//  test
//
//  Created by wushengran on 18/1/2.
//  Copyright © 2018年 dq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (datePicker)

@property (nonatomic)UIView *datePickerView;
@property (nonatomic)UIDatePicker *datePicker;
@property (nonatomic)void(^ completionHandler)(NSString *dateStrShow, NSString *dateStr);
@property (nonatomic)NSString *strFormatter;
@property (nonatomic)NSString *dateFormatter;

- (void)pushDatePickerViewWithDateFormatter:(NSString *)dateFormatter strFormatter:(NSString *)strFormatter mode:(UIDatePickerMode)mode minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate completion:(void(^)(NSString *dateStrShow, NSString *dateStr))completionHandler;
- (void)popDatePickerView;

//- (void)getDateWithFormatter:(NSString *)formatter completion:(void(^)(NSString *dateStr))completionHandler;
@end
