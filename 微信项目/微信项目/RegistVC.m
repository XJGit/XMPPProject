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
@property (weak, nonatomic) IBOutlet UIButton *regist;


@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _user.delegate = self;
    
}

- (IBAction)regist:(id)sender {
#warning 需要先从服务器获取数据得知号码是否被注册过
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"确定向%@发送验证码？",_user.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    alert.delegate = self;
}

#pragma mark - textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //判断手机号码是否正确
    BOOL flag;
    if (![string isEqualToString:@""]) {
        flag = [[MessageVerify showInstance] verfyTel:[_user.text stringByAppendingString:string]];
    }
    else {
        flag = [[MessageVerify showInstance] verfyTel:[_user.text substringToIndex:_user.text.length - 1]];
    }
    //设置button属性
    if (flag) {
        _regist.backgroundColor = [UIColor colorWithRed:95/255.0 green:190/255.0 blue:25/155.0 alpha:1];
        _regist.enabled = YES;
    }
    else{
        _regist.backgroundColor = [UIColor lightGrayColor];
        _regist.enabled = NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
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
                [self.navigationController pushViewController:verifyVC animated:YES];
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
