//
//  FinishRegistVC.m
//  微信项目
//
//  Created by Mac on 15/9/5.
//  Copyright (c) 2015年 Zeng. All rights reserved.
//

#import "FinishRegistVC.h"
#import "MessageVerify.h"
@interface FinishRegistVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *verifyPwd;
@property (weak, nonatomic) IBOutlet UIButton *regist;
@property (weak, nonatomic) UITextField *lastEdit;

@end

@implementation FinishRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _name.delegate = self;
    _password.delegate = self;
    _verifyPwd.delegate = self;
}

#pragma mark - 注册
- (IBAction)finshRegist:(id)sender {
    [self whetherPwdIsRight:_lastEdit];
}

#pragma mark - textfield代理
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    return YES;
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _lastEdit = textField;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self whetherPwdIsRight:textField];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self whetherPwdIsRight:textField];
    return YES;
}

#pragma mark - 公共方法
- (void)whetherPwdIsRight:(UITextField *)textField{
    if (textField == _password) {
        BOOL flag = [[MessageVerify showInstance] verfyTel:textField.text];
        if (!flag) {
            NSLog(@"密码非法，密码必须由字母和数字组成且大于六位数");
        }
        else{
            NSLog(@"密码正确");
        }
    }
    else if (textField == _verifyPwd){
        if (![textField.text isEqualToString:_password.text]) {
            NSLog(@"密码不匹配");
        }
    }

}
@end
