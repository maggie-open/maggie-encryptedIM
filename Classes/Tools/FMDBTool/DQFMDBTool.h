//
//  DQFMDBTool.h
//  MaggieDating
//
//  Created by 邓琼 on 2017/11/24.
//  Copyright © 2017年 com.maggie.social.MaggieDating. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface DQFMDBTool : NSObject

+ (FMDatabase *)sharedDatabase;

@end
