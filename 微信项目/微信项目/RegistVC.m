//
//  RegistVC.m
//  微信项目
//
//  Created by Mac on 15/9/4.
//  Copyright (c) 2015年 Zeng. All rights reserved.
//

#import "RegistVC.h"
#import "MessageVerify.h"
#import <SMS_SDK/SMS_SDK.h>
#import "NSString+Hash.h"

@interface RegistVC ()<UITextFieldDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UITextField *verifyPwd;
@property (weak, nonatomic) IBOutlet UIButton *regist;
@property (weak, nonatomic) IBOutlet UILabel *userWarn;

@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _user.delegate = self;
    _pwd.delegate = self;
    _verifyPwd.delegate = self;
}

- (IBAction)regist:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"确定向%@发送验证码？",_user.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    alert.delegate = self;
}

#pragma mark - textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    BOOL flag = [[MessageVerify showInstance] verfyTel:[textField.text stringByAppendingString:string]];
    if (!flag) {
        _userWarn.text = @"请输入正确的手机号";
    }
    else{
        _userWarn.text = nil;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [textField resignFirstResponder];
    
    //
    if (![_userWarn.text isEqualToString:@""] || _userWarn == nil) {
        _regist.enabled = YES;
        _regist.alpha = 1.0;
    }
    
    return YES;
}

#pragma mark - alertViewDelegate

- (void)alertViewCancel:(UIAlertView *)alertView{
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (1 == buttonIndex) {
        [SMS_SDK getVerificationCodeBySMSWithPhone:_user.text zone:@"86" result:^(SMS_SDKError *error) {
            if (!error) {
                NSLog(@"发送成功");
                UIViewController *verifyVC = [[UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"CodeVerifyVC"];
                [self presentViewController:verifyVC animated:YES completion:^{
                }];
            }
            else{
                NSLog(@"%@", error.errorDescription);
                NSLog(@"发送失败");
            }
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
