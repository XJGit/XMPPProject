//
//  AppDelegate.m
//  微信项目
//
//  Created by Mac on 15/8/29.
//  Copyright (c) 2015年 Zeng. All rights reserved.
//


#import "AppDelegate.h"
#import <SMS_SDK/SMS_SDK.h>
#import "XMPPFramework.h"

/**
 登录流程：
 1.初始化xmppStraem
 2.连接服务器（传一个jid）
 3.连接成功后发送密码
 
 */
#define appKey @"a23e6642807a"
#define appSecret @"3c087516dfec767d5b731ffaadcf9e1e"

@interface AppDelegate ()<XMPPStreamDelegate>{
    XMPPStream *_xmppStream;//与服务器交互核心类
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [SMS_SDK registerApp:appKey withSecret:appSecret];
    return YES;
}

#pragma mark - xmpp
- (void)setupXmppStream{
    _xmppStream = [[XMPPStream alloc] init];
    
    //设置代理
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

- (void)connecToHost{
    //用户jid
    XMPPJID *JID = [XMPPJID jidWithUser:@"" domain:@"zeng.local" resource:@"iphone"];
    //主机地址
    _xmppStream.hostName = @"127.0.0.1";
    //主机端口
    _xmppStream.hostPort = 5222;
    //发起连接
    NSError *error;
    [_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error];
    if (!error) {
        NSLog(@"发起连接成功");
    }
    else{
        NSLog(@"%@", error);
    }
}

- (void)sendPwdToHost{
    NSError *error;
    [_xmppStream authenticateWithPassword:@"" error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    else{
        NSLog(@"登录成功");
    }
}

#pragma mark -xmpp代理
#pragma mark - 连接建立成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    [self sendPwdToHost];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
