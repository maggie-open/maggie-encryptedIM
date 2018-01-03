//
//  DQEaseMobCallManager.h
//  MaggieDating
//
//  Created by 邓琼 on 2017/11/28.
//  Copyright © 2017年 com.maggie.social.MaggieDating. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Hyphenate/Hyphenate.h>
#import "EMCallOptions+NSCoding.h"

@interface DQEaseMobCallManager : NSObject

#if DEMO_CALL == 1

@property (strong, nonatomic) UIViewController *mainController;

+ (instancetype)sharedManager;

- (void)saveCallOptions;

- (void)makeCallWithUsername:(NSString *)aUsername
                        type:(EMCallType)aType;

- (void)answerCall:(NSString *)aCallId;

- (void)hangupCallWithReason:(EMCallEndReason)aReason;

#endif

@end
