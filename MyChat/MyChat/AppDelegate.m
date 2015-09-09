//
//  AppDelegate.m
//  MyChat
//
//  Created by Mac on 15/8/29.
//  Copyright (c) 2015年 Zeng. All rights reserved.
//


#import "AppDelegate.h"
#import <SMS_SDK/SMS_SDK.h>
#import "Account.h"
#import "XMPPTool.h"

/**
 登录流程：
 1.初始化xmppStraem
 2.连接服务器（传一个jid）
 3.连接成功后发送密码
 
 */
#define appKey @"a23e6642807a"
#define appSecret @"3c087516dfec767d5b731ffaadcf9e1e"

#define userKey @"user"
#define pwdKey @"pwd"
#define isLoginKey @"isLogin"


@interface AppDelegate (){
    
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //登录
    [Account shareInstance].isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:isLoginKey];
    if ([Account shareInstance].isLogin) {
        _window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
        [Account shareInstance].loginUser = [[NSUserDefaults standardUserDefaults] objectForKey:userKey];
        [Account shareInstance].loginPwd = [[NSUserDefaults standardUserDefaults] objectForKey:pwdKey];
        [[XMPPTool shareInsans] XMPPLogin:nil];
    }
    else{
        _window.rootViewController = [[UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    }
    //短信验证
    [SMS_SDK registerApp:appKey withSecret:appSecret];
    return YES;
}




#pragma mark - appDelegate
- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
