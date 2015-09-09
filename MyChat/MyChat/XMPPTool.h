//
//  XMPPTool.h
//  MyChat
//
//  Created by Mac on 15/9/9.
//  Copyright © 2015年 Zeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
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
@end
