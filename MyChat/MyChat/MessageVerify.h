//
//  MessageVerify.h
//  MyChat
//
//  Created by Mac on 15/9/2.
//  Copyright © 2015年 Zeng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MessageVerify : NSObject

/**
 * @brief 获得唯一实例
 *
 * @return 返回唯一实例
 */
+ (instancetype)shareInstance;

/**
 * @brief 验证手机号
 *  
 * @param tel 需验证的手机号
 *
 * @return 成YES 失败NO
 */
- (BOOL)verifyTel:(NSString *)tel;

/**
 * @brief 验证密码
 *
 * @param tel 需验证的密码
 *
 * @return 成YES 失败NO
 */
- (BOOL)verifyPwd:(NSString *)pwd;

@end
