//
//  FilterVC.m
//  MyChat
//
//  Created by Mac on 15/9/11.
//  Copyright © 2015年 Zeng. All rights reserved.
//

#import "QRCodeVC.h"
#import "UIImage+QRCodeImage.h"
#import "Account.h"
@interface QRCodeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImageView;

@end

@implementation QRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _QRCodeImageView.image = [UIImage createQRForString:[Account shareInstance].loginUser];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * 分享
 */
- (IBAction)Reply:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"QRCodeVC 销毁");
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
