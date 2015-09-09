//
//  LoginVC.m
//  MyChat
//
//  Created by Mac on 15/8/29.
//  Copyright (c) 2015年 Zeng. All rights reserved.
//

#import "LoginVC.h"
#import "MessageVerify.h"
#import "NSString+Hash.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Account.h"
#import "XMPPTool.h"

@interface LoginVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong)NSString *str;
@end


@implementation LoginVC


- (void)viewDidLoad {
    [super viewDidLoad];
    _user.delegate = self;
    _pwd.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _user.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
}

#pragma mark - login
- (IBAction)login:(id)sender {
    MBProgressHUD *mb = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    mb.labelText = @"loading...";
    if (_user.text.length != 0 && _pwd.text.length != 0) {
        [Account shareInstance].loginUser = _user.text;
        [Account shareInstance].loginPwd = [_pwd.text hmacMD5StringWithKey:@"pwd"];
        [XMPPTool shareInsans].registOperation = NO;
         [[XMPPTool shareInsans] XMPPLogin:^(XMPPResultType result) {
            if (result == XMPPResultLoginSuccess) {
                [mb hide:YES];
                [Account shareInstance].isLogin = YES;
                [[Account shareInstance] saveToSandBox];
            }
            else{
                mb.mode = MBProgressHUDModeText;
                mb.labelText = @"账号或密码错误";
                [mb hide:YES afterDelay:1.0];
            }
        }];
    }
    else{
        mb.dimBackground = NO;
        mb.mode = MBProgressHUDModeText;
        mb.labelText = @"请输入密码";
        [mb hide:YES afterDelay:1.0];
        return;
    }
}

#pragma mark - TextFieldRetun
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
