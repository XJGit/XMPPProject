//
//  CodeVerify.m
//  MyChat
//
//  Created by Mac on 15/9/4.
//  Copyright (c) 2015年 Zeng. All rights reserved.
//

#import "CodeVerifyVC.h"
#import <SMS_SDK/SMS_SDK.h>

@interface CodeVerifyVC ()
@property (weak, nonatomic) IBOutlet UITextField *verifyCode;

@end

@implementation CodeVerifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 提交验证码
- (IBAction)next:(id)sender {
    [SMS_SDK commitVerifyCode:_verifyCode.text result:^(enum SMS_ResponseState state) {
        if (state == SMS_ResponseStateFail) {
            NSLog(@"验证码错误");
        }
        else{
            NSLog(@"验证成功！");
            UIViewController *VC = [[UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Finish"];
            [self presentViewController:VC animated:YES completion:^{
                
            }];
        }
    }];
}

@end
