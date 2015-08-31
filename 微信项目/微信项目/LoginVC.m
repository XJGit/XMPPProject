//
//  LoginVC.m
//  微信项目
//
//  Created by Mac on 15/8/29.
//  Copyright (c) 2015年 Zeng. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (nonatomic, strong)NSString *str;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)login:(id)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (_user.text.length != 0 && _pwd.text.length != 0) {
        [userDefault setObject:_user.text forKey:@"user"];
        [userDefault setObject:_pwd.text forKey:@"pwd"];
    }
    else{
        return;
    }
}



@end
