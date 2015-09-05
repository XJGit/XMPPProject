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
@interface LoginVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *labelWarn;
@property (nonatomic, strong)NSString *str;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _user.delegate = self;
    _pwd.delegate = self;
    
}

#pragma mark - login
- (IBAction)login:(id)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (_user.text.length != 0 && _pwd.text.length != 0) {
        [userDefault setObject:_user.text forKey:@"user"];
        [userDefault setObject:_pwd.text.md5String forKey:@"pwd"];
        
    }
    else{
        return;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    BOOL flag = NO;
    if (textField == _user) {
        flag = [[MessageVerify showInstance] verfyTel:textField.text];
        if (!flag) {
            _labelWarn.text = @"请输入正确的手机号";
//            UILabel *warn = [[UILabel alloc] init];
//            [_contentView addSubview:warn];
//            warn.text = @"请输入正确的手机号";
//            NSLayoutConstraint *consRight = [NSLayoutConstraint constraintWithItem:warn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_user attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
//            NSLayoutConstraint *consTop = [NSLayoutConstraint constraintWithItem:warn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_user attribute:NSLayoutAttributeTop multiplier:1.0 constant:-30];
//            [_contentView addConstraint:consRight];
//            [_contentView addConstraint:consTop];
            NSLog(@"请输入正确的手机号");
        }
        else{
            _labelWarn.text = nil;
        }
        
    }
    else if(textField == _pwd){
        flag = [[MessageVerify showInstance] verfyPwd:textField.text];
        if (!flag) {
            NSLog(@"密码非法");
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
