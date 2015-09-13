//
//  MeVC.m
//  MyChat
//
//  Created by Mac on 15/9/9.
//  Copyright © 2015年 Zeng. All rights reserved.
//

#import "MeVC.h"
#import "AppDelegate.h"
#import "Account.h"
#import "XMPPTool.h"
#import "XMPPvCardTemp.h"

@interface MeVC ()
@property (weak, nonatomic) IBOutlet UILabel *userNmae;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;



@end

@implementation MeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userNmae.text = [NSString stringWithFormat:@"MyChat:%@", [Account shareInstance].loginUser];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    XMPPvCardTemp *vCard = [XMPPTool shareInsans].vCard.myvCardTemp;
    if (vCard.photo) {
        _headImage.image = [UIImage imageWithData:vCard.photo];
    }
}
#pragma mark - 
- (IBAction)loginOut:(id)sender {
    [[XMPPTool shareInsans] loginOut];
    ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = [[UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    [Account shareInstance].isLogin = NO;
    [[Account shareInstance] saveLoginToSandBox];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"meVC 销毁");
}

@end
