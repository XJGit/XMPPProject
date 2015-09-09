//
//  Account.m
//  MyChat
//
//  Created by Mac on 15/9/9.
//  Copyright © 2015年 Zeng. All rights reserved.
//

#import "Account.h"

#define userKey @"user"
#define pwdKey @"pwd"
#define isLoginKey @"isLogin"
@implementation Account

+ (instancetype)shareInstance{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static Account *account;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        account = [super allocWithZone:zone];
        account.loginUser = [[NSUserDefaults standardUserDefaults] objectForKey:userKey];
        account.loginPwd = [[NSUserDefaults standardUserDefaults] objectForKey:pwdKey];
        account.isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:isLoginKey];
    });
    return account;
}

- (void)saveToSandBox{
    //存储用户信息
    [[NSUserDefaults standardUserDefaults] setObject:[Account shareInstance].loginUser forKey:@"user"];
    [[NSUserDefaults standardUserDefaults] setObject:[Account shareInstance].loginPwd forKey:@"pwd"];
    [self saveLoginToSandBox];
}

- (void)saveLoginToSandBox{
    [[NSUserDefaults standardUserDefaults] setBool:[Account shareInstance].isLogin forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
