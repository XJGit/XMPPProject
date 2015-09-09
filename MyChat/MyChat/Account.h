//
//  Account.h
//  MyChat
//
//  Created by Mac on 15/9/9.
//  Copyright © 2015年 Zeng. All rights reserved.
//

/**
 * 此类为一个单例类
 */
#import <Foundation/Foundation.h>

@interface Account : NSObject
/**
 * 登录
 */
@property (nonatomic, copy)NSString *loginUser;
@property (nonatomic, copy)NSString *loginPwd;
@property (nonatomic, assign)BOOL isLogin;

/**
 * 注册
 */
@property (nonatomic, copy)NSString *registUser;
@property (nonatomic, copy)NSString *registPwd;
+ (instancetype)shareInstance;

/**
 * 将用户信息保存到沙盒
 */
- (void)saveToSandBox;

/**
 * 只将isLogin保存到沙盒
 */
- (void)saveLoginToSandBox;
@end
