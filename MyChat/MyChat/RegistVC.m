//
//  RegistVC.m
//  MyChat
//
//  Created by Mac on 15/9/4.
//  Copyright (c) 2015年 Zeng. All rights reserved.
//

#import "RegistVC.h"
#import "MessageVerify.h"
#import <SMS_SDK/SMS_SDK.h>
#import "NSString+Hash.h"
#import "AlertView.h"
#import "XMPPTool.h"
#import "Account.h"

#define INTERVAL 60

@interface RegistVC ()<UITextFieldDelegate, UIAlertViewDelegate>{
    NSInteger _interval;//重发验证码时长（默认60s）
}
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UITextField *verifyCode;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UIButton *regist;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;


@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _phoneNum.delegate = self;
    _interval = INTERVAL;
}

#pragma mark - 获取验证码
- (IBAction)verifyCode:(id)sender {
    [self.view endEditing:YES];
    BOOL flag = [[MessageVerify shareInstance] verifyTel:_phoneNum.text];
    if (!flag) {
        [[AlertView initInstance] showWithMessage:@"请输入正确的手机号码"];
        return;
    }
    
    if (![[MessageVerify shareInstance] verifyPwd:_pwd.text]) {
        [[AlertView initInstance] showWithMessage:@"请输入6～10位密码"];
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"确定向%@发送验证码？",_phoneNum.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    alert.delegate = self;
}

#pragma mark - 注册
- (IBAction)regist:(id)sender {
    [self.view endEditing:YES];
    BOOL flag = [[MessageVerify shareInstance] verifyTel:_phoneNum.text];
    //校验手机号
    if (!flag) {
        [[AlertView initInstance] showWithMessage:@"请输入正确的手机号码"];
        return;
    }
    //校验密码
    if (![[MessageVerify shareInstance] verifyPwd:_pwd.text]) {
        [[AlertView initInstance] showWithMessage:@"请输入6～10位密码"];
        return;
    }
    //验证验证码
    [SMS_SDK commitVerifyCode:_verifyCode.text result:^(enum SMS_ResponseState state) {
        if (state == SMS_ResponseStateFail) {
            [[AlertView initInstance] showWithMessage:@"验证码错误"];
        }
        else{
            //
            [Account shareInstance].registUser = _phoneNum.text;
            [Account shareInstance].registPwd = [_pwd.text hmacMD5StringWithKey:@"pwd"];
            [Account shareInstance].loginUser = [Account shareInstance].registUser;
            [XMPPTool shareInsans].registOperation = YES;
            [[XMPPTool shareInsans] XMPPRegist:^(XMPPResultType result) {
                if (result == XMPPresultRegistFialuer) {
                    NSLog(@"注册失败,这个号码已经被注册了，请直接登录");
                }
            }];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - alertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.view endEditing:YES];
    if (1 == buttonIndex) {
        
        [SMS_SDK getVerificationCodeBySMSWithPhone:_phoneNum.text zone:@"86" result:^(SMS_SDKError *error) {
            if (!error) {
                NSLog(@"发送成功");
                [_verifyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                _verifyBtn.enabled = NO;
                [[AlertView initInstance] showWithMessage:@"我们已向您的手机发送了一个验证码"];
                [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeVerifyBtnTitle:) userInfo:nil repeats:YES];
            }
            else{
                NSLog(@"%@", error.errorDescription);
                NSLog(@"发送失败");
            }
        }];
    }
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - changeTitle

- (void)changeVerifyBtnTitle:(NSTimer *)timer{
    _interval --;
    if (0 == _interval) {
        _interval = INTERVAL;
        _verifyBtn.enabled = YES;
        [_verifyBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_verifyBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [timer invalidate];
        return;
    }
    [_verifyBtn setTitle:[NSString  stringWithFormat:@"%lis后重发",_interval] forState:UIControlStateNormal];
}


@end
