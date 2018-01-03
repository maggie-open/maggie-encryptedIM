//
//  DQEaseMobChatHelper.h
//  MaggieDating
//
//  Created by 邓琼 on 2017/11/28.
//  Copyright © 2017年 com.maggie.social.MaggieDating. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ConversationListController.h"
#import "ContactListViewController.h"
#import "MainViewController.h"
#import "ZJChatViewController.h"

#define kHaveUnreadAtMessage    @"kHaveAtMessage"
#define kAtYouMessage           1
#define kAtAllMessage           2

@interface DQEaseMobChatHelper : NSObject <EMClientDelegate, EMMultiDevicesDelegate,EMChatManagerDelegate,EMContactManagerDelegate,EMGroupManagerDelegate,EMChatroomManagerDelegate>

@property (nonatomic, weak) ContactListViewController *contactViewVC;

@property (nonatomic, weak) ConversationListController *conversationListVC;

@property (nonatomic, strong) MainViewController *mainVC;

@property (nonatomic, weak) ZJChatViewController *chatVC;

+ (instancetype)shareHelper;

- (void)asyncPushOptions;

- (void)asyncGroupFromServer;

- (void)asyncConversationFromDB;

- (BOOL)isFetchHistoryChange;

@end
