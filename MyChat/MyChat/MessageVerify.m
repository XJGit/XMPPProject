//
//  MessageVerify.m
//  MyChat
//
//  Created by Mac on 15/9/2.
//  Copyright © 2015年 Zeng. All rights reserved.
//

#import "MessageVerify.h"

static MessageVerify *messageVerfy;
@implementation MessageVerify


+ (instancetype)showInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        messageVerfy = [[self alloc] init];
    });
    return messageVerfy;
}

#pragma mark - 验证手机号
- (BOOL)verfyTel:(NSString *)tel{
    //此正则表达式匹配所13、15、18开头的手机号^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$
    NSString *regex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    return [self verfyStr:tel withRegex:regex];
}

#pragma mark - 验证密码
- (BOOL)verfyPwd:(NSString *)pwd{
    NSString *regex = @"^[a-zA-Z0-9]{6,20}+$";
    return [self verfyStr:pwd withRegex:regex];
}

#pragma mark - 公共方法
- (BOOL)verfyStr:(NSString *)str withRegex:(NSString *)regex{
    if (str.length == 0) {
        return NO;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL flag = [predicate evaluateWithObject:str];
    return flag;
}

@end
