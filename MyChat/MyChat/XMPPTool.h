//
//  XMPPTool.h
//  MyChat
//
//  Created by Mac on 15/9/9.
//  Copyright © 2015年 Zeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XMPPFramework.h"

typedef enum {
    XMPPResultLoginSuccess = 0,
    XMPPResultLoginFialuer,
    XMPPResultRegistSuccess,
    XMPPresultRegistFialuer
}XMPPResultType;

//定义一个block
typedef void (^XMPPResultTypeBlock)(XMPPResultType);

@interface XMPPTool : NSObject

/**
 * 用来判断是注册还时登陆
 */
@property (nonatomic, assign, getter=isRegistOperation)BOOL registOperation;
//电子名片模块
@property (nonatomic, strong)XMPPvCardTempModule *vCard;
//电子名片头像模块
@property (nonatomic, strong)XMPPvCardAvatarModule *avatar;

@property (nonatomic, strong)XMPPRoster *roster;
@property (nonatomic, strong)XMPPRosterCoreDataStorage *rosterStorage;//花名册存储

/**
 * ／／／／／／／
 */
+ (instancetype)shareInsans;

/**
 * 登录到xmpp服务器
 */
- (void)XMPPLogin:(XMPPResultTypeBlock)result;

/**
 * 注销
 */
- (void)loginOut;

/**
 * 注册
 */
- (void)XMPPRegist:(XMPPResultTypeBlock)result;

/**
 * 释放资源
 */
- (void)tearDoenStream;
@end
