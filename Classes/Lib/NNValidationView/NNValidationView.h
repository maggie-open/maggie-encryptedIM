#import <UIKit/UIKit.h>
typedef void(^NNChangeValidationCodeBlock)(void);


/**
 图形验证码
 */
@interface NNValidationView : UIView

@property (nonatomic, copy) NSArray *charArray;

@property (nonatomic, strong) NSMutableString *charString;

@property (nonatomic, copy) NNChangeValidationCodeBlock changeValidationCodeBlock;

- (void)changeCharString;

- (instancetype)initWithFrame:(CGRect)frame andCharCount:(NSInteger)charCount andLineCount:(NSInteger)lineCount;

@end
