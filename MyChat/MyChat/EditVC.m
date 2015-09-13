//
//  EditVC.m
//  MyChat
//
//  Created by Mac on 15/9/11.
//  Copyright © 2015年 Zeng. All rights reserved.
//

#import "EditVC.h"



@interface EditVC ()

//用户信息
@property (weak, nonatomic) IBOutlet UITextField *message;

@end

@implementation EditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _cell.textLabel.text;
    _message.text = _cell.detailTextLabel.text;
}
- (IBAction)saveMessage:(id)sender {
    self.cell.detailTextLabel.text = _message.text;

    [self.navigationController popViewControllerAnimated:YES];
    
    if ([_delegate respondsToSelector:@selector(didFinidhSave)]) {
        [_delegate didFinidhSave];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"editVC 销毁");
}

@end
