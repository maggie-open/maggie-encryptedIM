//
//  UIView+datePicker.m
//  test
//
//  Created by wushengran on 18/1/2.
//  Copyright © 2016年 dq. All rights reserved.
//

#import "UIView+datePicker.h"
#import <objc/runtime.h>

static const void *datePickerViewKey = &datePickerViewKey;
static const void *datePickerKey = &datePickerKey;
static const void *completionHandlerKey = &completionHandlerKey;
static const void *dateFormatterKey = &dateFormatterKey;
static const void *strFormatterKey = &strFormatterKey;

@implementation UIView (datePicker)
// 动态实现属性的setter getter方法
- (void)setDatePickerView:(UIView *)datePickerView {
    objc_setAssociatedObject(self, datePickerViewKey, datePickerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)datePickerView {
    return objc_getAssociatedObject(self, datePickerViewKey);
}
- (void)setDatePicker:(UIDatePicker *)datePicker {
    objc_setAssociatedObject(self, datePickerKey, datePicker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIDatePicker *)datePicker {
    return objc_getAssociatedObject(self, datePickerKey);
}
- (void)setCompletionHandler:(void (^)(NSString *, NSString *))completionHandler {
    objc_setAssociatedObject(self, completionHandlerKey, completionHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void (^)(NSString *, NSString *))completionHandler {
    return objc_getAssociatedObject(self, completionHandlerKey);
}

- (void)setStrFormatter:(NSString *)strFormatter {
    objc_setAssociatedObject(self, strFormatterKey, strFormatter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)strFormatter {
    return objc_getAssociatedObject(self, strFormatterKey);
}
- (void)setDateFormatter:(NSString *)dateFormatter {
    objc_setAssociatedObject(self, dateFormatterKey, dateFormatter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)dateFormatter {
    return objc_getAssociatedObject(self, dateFormatterKey);
}


#pragma mark -- public
- (void)pushDatePickerViewWithDateFormatter:(NSString *)dateFormatter strFormatter:(NSString *)strFormatter mode:(UIDatePickerMode)mode minDate:(NSDate *)minDate maxDate:(NSDate *)maxDate completion:(void(^)(NSString *dateStrShow, NSString *dateStr))completionHandler {
    [self endEditing:YES];
    
    self.dateFormatter = dateFormatter;
    self.strFormatter = strFormatter;
    self.completionHandler = completionHandler;
    
    self.datePickerView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.datePickerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.datePickerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popDatePickerView)]];
    
    UIView *lowerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.datePickerView.bounds.size.height-180, self.datePickerView.bounds.size.width, 180)];
    lowerView.backgroundColor = [UIColor colorWithRed:1.0 green:0.98 blue:0.98 alpha:1];
    lowerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    lowerView.layer.borderWidth = 0.5;

    [self.datePickerView addSubview:lowerView];
    
    UIButton *cancle = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    [cancle setTitleColor:[UIColor colorWithRed:66/255.0 green:66/255.0 blue:66/255.0 alpha:1] forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(popDatePickerView) forControlEvents:UIControlEventTouchUpInside];
    [lowerView addSubview:cancle];
    
    UIButton *pickDate = [[UIButton alloc]initWithFrame:CGRectMake(self.datePickerView.bounds.size.width-60, 0, 60, 40)];
    [pickDate setTitle:@"确定" forState:UIControlStateNormal];
    [pickDate setTitleColor:[UIColor colorWithRed:67/255.0 green:175/255.0 blue:108/255.0 alpha:1] forState:UIControlStateNormal];
    [pickDate addTarget:self action:@selector(pickDate) forControlEvents:UIControlEventTouchUpInside];
    [lowerView addSubview:pickDate];
    
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 40, self.datePickerView.bounds.size.width, 140)];
    self.datePicker.datePickerMode = mode;
    self.datePicker.minimumDate = minDate;
    self.datePicker.maximumDate = maxDate;
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.datePicker.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.datePicker.layer.borderWidth = 0.5;
    [lowerView addSubview:self.datePicker];
    
    [self.window addSubview:self.datePickerView];
}

- (void)popDatePickerView {
    [self.datePickerView removeFromSuperview];
}


- (void)pickDate {
    NSDate *selected = [self.datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:self.dateFormatter];
    NSString *dateStrShow =  [dateFormatter stringFromDate:selected];
    [dateFormatter setDateFormat:self.strFormatter];
    NSString *dateStr = [dateFormatter stringFromDate:selected];
    self.completionHandler(dateStrShow, dateStr);
    [self.datePickerView removeFromSuperview];
}


@end
