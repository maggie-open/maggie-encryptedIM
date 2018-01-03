//
//  ZJCahtViewController.m
//  FactBiz
//
//  Created by 邓琼 on 2017/11/1.
//  Copyright © 2017年 Deng. All rights reserved.
//

#import "ZJChatViewController.h"
#import "DQEaseMobCallManager.h"
#import "JDAESUtil.h"
#import <EaseCustomMessageCell.h>
#import <UIImage+GIF.h>
#import "DQFMDBChatAes.h"
#import <UIViewController+HUD.h>
#import "JDKeyChainWapper.h"
#import "JDRSAUtil.h"

@interface ZJChatViewController ()

@property (nonatomic, assign) BOOL isEncrypt;

@property (nonatomic, assign) BOOL hasSentChatKey;

/** 对方的公钥 */
@property (nonatomic, strong)NSString *chatPubKey;

@end

@implementation ZJChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[DQEaseMobCallManager sharedManager] setMainController:self];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"开启加密" style:UIBarButtonItemStylePlain target:self action:@selector(openOrCloseEncrypt)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openOrCloseEncrypt {
    self.isEncrypt = !self.isEncrypt;
    [self.navigationItem.rightBarButtonItem setTitle:self.isEncrypt?@"关闭加密":@"开启加密"];
    
    if (!self.isEncrypt) {
        return;
    }
    
    if (![DQFMDBChatAes getChatAesKeyWithEaseMobID:self.conversation.conversationId]) {
        DLog(@"没有秘钥");
#warning  去服务器请求会话对象的公钥
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //模拟请求
            self.chatPubKey = [self.conversation.conversationId isEqualToString:@"ab"]?
            @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCfD9Yl896v/LZGuLyFS7hlET6uvStHK5zV/rl8aoXP0XpTCLTkRFMX1qOT86vCqq96IJ4aJhnGh1q2SQRrLBXao5d9DzPEY8JadFBm61jscokHtNI4QFa2KMsTkC/jy266C6RwKn0zD2cDa4NP+mbt57w/E2V1KhbM2ZyKwftGTwIDAQAB"
            :@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDHZZw8n83nxcc55RdpYZni76+reKWJx7ZqzgaBLwXD/fiMjGI0sfUH1bsGxLm3FrcN6WQEExAQ+SkTsMReznJXJyRJVFYo5KLs+CtlZrc0a9mr7R6EO0jWv1QJQHU7r7tMPi4oYe7XCPZb6KdyrOSNcyOUbb4ZNem1YNy/UNGW0QIDAQAB";
            
            //拿到对方公钥，生成秘钥，存储秘钥
            DQFMDBChatAes *chatAes = [DQFMDBChatAes new];
            chatAes.easeMobID = self.conversation.conversationId;
            chatAes.chatAesKey = [self randomKey];
            [DQFMDBChatAes insertUserToDB:chatAes];
        });
    }
}



- (void)sendTextMessage:(NSString *)text {
    NSString *str = text;
    NSDictionary *ext = nil;
    if (self.isEncrypt) {
        if (![DQFMDBChatAes getChatAesKeyWithEaseMobID:self.conversation.conversationId]) {
            [self.view.window showWarning:@"正在请求加密会话，请稍后"];
            return;
        }
        if (!self.hasSentChatKey) { //加密秘钥，置入消息的扩展信息中(发送秘钥后不再发送)
            self.hasSentChatKey = YES;
            NSString *encryptedKey = [JDRSAUtil encryptString:[DQFMDBChatAes getChatAesKeyWithEaseMobID:self.conversation.conversationId] publicKey:self.chatPubKey];
            ext = @{@"chatAesKey":encryptedKey};
        }
        str = [JDAESUtil encrypt:text password:[DQFMDBChatAes getChatAesKeyWithEaseMobID:self.conversation.conversationId]];
        str = [kAESMark stringByAppendingString:str];
    }
    [super sendTextMessage:str withExt:ext];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self.dataArray objectAtIndex:indexPath.row];
    
    //time cell
    if ([object isKindOfClass:[NSString class]]) {
        NSString *TimeCellIdentifier = [EaseMessageTimeCell cellIdentifier];
        EaseMessageTimeCell *timeCell = (EaseMessageTimeCell *)[tableView dequeueReusableCellWithIdentifier:TimeCellIdentifier];
        
        if (timeCell == nil) {
            timeCell = [[EaseMessageTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TimeCellIdentifier];
            timeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        timeCell.title = object;
        return timeCell;
    } else { //消息cell
        id<IMessageModel> model = object;
        if (self.delegate && [self.delegate respondsToSelector:@selector(messageViewController:cellForMessageModel:)]) {
            UITableViewCell *cell = [self.delegate messageViewController:tableView cellForMessageModel:model];
            if (cell) {
                if ([cell isKindOfClass:[EaseMessageCell class]]) {
                    EaseMessageCell *emcell= (EaseMessageCell*)cell;
                    if (emcell.delegate == nil) {
                        emcell.delegate = self;
                    }
                }
                return cell;
            }
        }
        
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(isEmotionMessageFormessageViewController:messageModel:)]) {
            BOOL flag = [self.dataSource isEmotionMessageFormessageViewController:self messageModel:model];
            if (flag) {
                NSString *CellIdentifier = [EaseCustomMessageCell cellIdentifierWithModel:model];
                //send cell
                EaseCustomMessageCell *sendCell = (EaseCustomMessageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                
                // Configure the cell...
                if (sendCell == nil) {
                    sendCell = [[EaseCustomMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:model];
                    sendCell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                
                if (self.dataSource && [self.dataSource respondsToSelector:@selector(emotionURLFormessageViewController:messageModel:)]) {
                    EaseEmotion *emotion = [self.dataSource emotionURLFormessageViewController:self messageModel:model];
                    if (emotion) {
                        model.image = [UIImage sd_animatedGIFNamed:emotion.emotionOriginal];
                        model.fileURLPath = emotion.emotionOriginalURL;
                    }
                }
                sendCell.model = model;
                sendCell.delegate = self;
                return sendCell;
            }
        }
        
        NSString *CellIdentifier = [EaseMessageCell cellIdentifierWithModel:model];
        
        EaseBaseMessageCell *sendCell = (EaseBaseMessageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (sendCell == nil) {
            sendCell = [[EaseBaseMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:model];
            sendCell.selectionStyle = UITableViewCellSelectionStyleNone;
            sendCell.delegate = self;
        }
        //解密加密信息
        if (model.bodyType == EMMessageBodyTypeText) {
            if ([model.text hasPrefix:kAESMark]) {
                model.text = [model.text substringFromIndex:kAESMark.length];
                NSString *decrypeInfo = [JDAESUtil decrypt:model.text password:[DQFMDBChatAes getChatAesKeyWithEaseMobID:self.conversation.conversationId]];
                if (decrypeInfo) {
                    model.text = decrypeInfo;
                }
            }
        }
        sendCell.model = model;
        return sendCell;
    }
}

#pragma mark -- 生成秘钥
//生成十二位随机字符串
- (NSString *)randomKey {
    
    NSString *alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()";
    
    // Get the characters into a C array for efficient shuffling
    NSUInteger numberOfCharacters = [alphabet length];
    unichar *characters = calloc(numberOfCharacters, sizeof(unichar));
    [alphabet getCharacters:characters range:NSMakeRange(0, numberOfCharacters)];
    
    // Perform a Fisher-Yates shuffle
    for (NSUInteger i = 0; i < numberOfCharacters; ++i) {
        NSUInteger j = (arc4random_uniform((float)numberOfCharacters - i) + i);
        unichar c = characters[i];
        characters[i] = characters[j];
        characters[j] = c;
    }
    
    // Turn the result back into a string
    NSString *result = [NSString stringWithCharacters:characters length:12];
    free(characters);
    return result;
}


@end
