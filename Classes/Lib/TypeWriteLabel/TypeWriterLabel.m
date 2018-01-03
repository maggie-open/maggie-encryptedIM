//
//  TypeWriterLabel.m
//  TestScrollView
//
//  Created by Tesla_Chen on 2017/6/16.
//  Copyright © 2017年 Telsa_Chen. All rights reserved.
//

#import "TypeWriterLabel.h"

@implementation TypeWriterLabel


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(void)startTypewrite
{
    
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    
   _timer = [NSTimer scheduledTimerWithTimeInterval:self.typewriteTimeInterval target:self selector:@selector(outPutWord:) userInfo:nil repeats:YES];
    [_timer fire];
    
}


-(void)outPutWord:(id)atimer
{
    if (self.text.length == self.currentIndex) {
        [atimer invalidate];
        atimer = nil;
        self.loadAllBlock?self.loadAllBlock():nil;
    }else{
        self.currentIndex++;
        NSDictionary *dic = @{NSForegroundColorAttributeName: self.typewriteEffectColor};
        NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc] initWithString:self.text];
        [mutStr addAttributes:dic range:NSMakeRange(0, self.currentIndex)];
        [self setAttributedText:mutStr];
        
    }
}

- (void)stopWrite {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
