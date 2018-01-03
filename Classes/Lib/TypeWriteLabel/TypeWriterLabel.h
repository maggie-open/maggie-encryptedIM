//
//  TypeWriterLabel.h
//  TestScrollView
//
//  Created by Tesla_Chen on 2017/6/16.
//  Copyright © 2017年 Telsa_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^loadAllWordsBlock)(void);

/**
 打字效果的标签
 */
@interface TypeWriterLabel : UILabel
/** Z
 *	设置单个字打印间隔时间，默认 0.3 秒
 */
@property (nonatomic) NSTimeInterval typewriteTimeInterval;

/** Z
 *	开始打印的位置索引，默认为0，即从头开始
 */
@property (nonatomic) int currentIndex;

/** Z
 *	输入字体的颜色
 */
@property (nonatomic, strong) UIColor *typewriteEffectColor;

/** Z
 *  开始打印
 */
-(void)startTypewrite;

/** Z
 *  定时器
 */
@property (nonatomic, strong) NSTimer  *timer;

/**  结束回调  */
@property (nonatomic, strong)loadAllWordsBlock loadAllBlock;

- (void)stopWrite;

@end
