//
//  XMPPTool.m
//  MyChat
//
//  Created by Mac on 15/9/9.
//  Copyright © 2015年 Zeng. All rights reserved.
//

#import "XMPPTool.h"
#import "XMPPFramework.h"
#import "Account.h"
#import "AppDelegate.h"

#define userKey @"user"
#define pwdKey @"pwd"
#define isLoginKey @"isLogin"

@interface XMPPTool()<XMPPStreamDelegate>{
    
    XMPPResultTypeBlock _xmppResultBlock;//登陆结果回调
}

@property (nonatomic, strong)XMPPStream *xmppStream;//与服务器交互核心类
@end

@implementation XMPPTool

+ (instancetype)shareInsans{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static XMPPTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [super allocWithZone:zone];
    });
    return tool;
}

#pragma mark - LoginToHost
- (void)XMPPLogin:(XMPPResultTypeBlock)reulst{
    _xmppResultBlock = reulst;
    //每次登陆之前都断开以前的连接
    [_xmppStream disconnect];
    [self connecToHost];
}

#pragma mark - LoginOut
- (void)loginOut{
    [self sendOffLine];
    [_xmppStream disconnect];
}

#pragma mark - 用户注册
- (void)XMPPRegist:(XMPPResultTypeBlock)result{
    _xmppResultBlock = result;
    [_xmppStream disconnect];
    [self connecToHost];
}

#pragma mark - xmpp
- (void)setupXmppStream{
    _xmppStream = [[XMPPStream alloc] init];
    //设置代理
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

- (void)connecToHost{
    if (!_xmppStream) {
        [self setupXmppStream];
    }
    NSString *user;
    //判断是登陆还是注册
    if (self.registOperation) {
        user = [Account shareInstance].registUser;
    }
    else{
        user = [Account shareInstance].loginUser;
    }
    //用户jid
    XMPPJID *JID = [XMPPJID jidWithUser:user domain:@"macdeimac.local" resource:@"iphone"];
    _xmppStream.myJID = JID;
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
    NSString *pwd;
    NSError *error;
    if (self.isRegistOperation) {
        pwd = [Account shareInstance].registPwd;
        [_xmppStream registerWithPassword:pwd error:&error];
    }
    else{
        pwd = [Account shareInstance].loginPwd;
        [_xmppStream authenticateWithPassword:pwd error:&error];
    }
}

/**
 * 发送在线请求
 */
- (void)sendOnline{
    XMPPPresence *presence = [XMPPPresence presence];
    [_xmppStream sendElement:presence];
}

#pragma mark - 发送离线请求
- (void)sendOffLine{
    XMPPPresence *offline = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:offline];
}

#pragma mark -xmpp代理
#pragma mark - 连接建立成功
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    [self sendPwdToHost];
}

#pragma mark - 登录成功，发送在线请求
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    //登陆成功
    if (_xmppResultBlock) {
        _xmppResultBlock(XMPPResultLoginSuccess);
    }
    ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    [self sendOnline];
}

#pragma mark - 登录失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    if (_xmppResultBlock) {
        _xmppResultBlock(XMPPResultLoginFialuer);
    }
}

#pragma mark - 注册成功
- (void)xmppStreamDidRegister:(XMPPStream *)sender{
    if (_xmppResultBlock) {
        _xmppResultBlock(XMPPResultRegistSuccess);
    }
    ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = [[UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
}

#pragma mark - 注册失败
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    if (_xmppResultBlock) {
        _xmppResultBlock(XMPPresultRegistFialuer);
    }
}
@end
