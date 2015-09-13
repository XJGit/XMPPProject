//
//  MyMessageVC.m
//  MyChat
//
//  Created by Mac on 15/9/10.
//  Copyright © 2015年 Zeng. All rights reserved.
//

#import "MyMessageVC.h"
#import "Account.h"
#import "UIImage+QRCodeImage.h"
#import "MeVC.h"
#import "XMPPFramework.h"
#import "Account.h"
#import "XMPPTool.h"
#import "XMPPvCardTemp.h"
#import "EditVC.h"

@interface MyMessageVC ()<EditVCDelegate, UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImage;
@property (weak, nonatomic) IBOutlet UIImageView *filter;
@property (weak, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *accountNum;
@property (weak, nonatomic) IBOutlet UITableViewCell *tel;

//@property (assign, nonatomic) BOOL isPush;//判断是push还是pop

@end

@implementation MyMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _filter.image = [UIImage createQRForString:[Account shareInstance].loginUser];
    XMPPvCardTemp *vCard = [XMPPTool shareInsans].vCard.myvCardTemp;
    if (vCard.photo) {
        _userHeadImage.image = [UIImage imageWithData:vCard.photo];
    }
    
    _nameCell.detailTextLabel.text = vCard.nickname;
    _accountNum.detailTextLabel.text = [Account shareInstance].loginUser;
    _tel.detailTextLabel.text = vCard.note;
    
}

- (void)didFinidhSave{
    XMPPvCardTemp *myVcard = [XMPPTool shareInsans].vCard.myvCardTemp;
    myVcard.photo = UIImageJPEGRepresentation(_userHeadImage.image, 0.5);
    myVcard.nickname = _nameCell.detailTextLabel.text;
    myVcard.note = _tel.detailTextLabel.text;
    [[XMPPTool shareInsans].vCard updateMyvCardTemp:myVcard];
}

//#pragma mark - 转场动画
//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
//    if ([toVC isKindOfClass:[MeVC class]]) {
//        return nil;
//    }
//    _isPush = !_isPush;
//    return self;
//}
//
//- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
//    return 0.3;
//}
//
//- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
//    UIView *containerView = [transitionContext containerView];
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIView *view;
//    CGAffineTransform transfrom;
//    float alpha;
//    if (self.isPush) {
//        [containerView insertSubview:toVC.view aboveSubview:fromVC.view];
//        view = toVC.view;
//        view.transform = CGAffineTransformMakeScale(0.2, 0.2);
//        view.alpha = 0.5;
//        transfrom = CGAffineTransformMakeScale(1, 1);
//        alpha = 1;
//    }
//    else{
//        [containerView insertSubview:toVC.view belowSubview:fromVC.view];
//        view = fromVC.view;
//        transfrom = CGAffineTransformMakeScale(0.2, 0.2);
//        alpha = 0.5;
//    }
//    [UIView animateWithDuration:0.3 animations:^{
//        view.transform = transfrom;
//        view.alpha = alpha;
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:YES];
//    }];
//}

- (void)dealloc{
    NSLog(@"MyMessageVC 销毁");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *editedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (editedCell.tag == 1) {
        [self performSegueWithIdentifier:@"toEditVC" sender:editedCell];
    }
    else if (editedCell.tag == 0){
        [self choseImage];
    }
    
}

#pragma mark - 选择图片
- (void)choseImage{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"图片墙", nil];
    [action showInView:self.view];
}

#pragma mark - ActonSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UIImagePickerController *imageVC = [[UIImagePickerController alloc] init];
    imageVC.delegate = self;
    imageVC.allowsEditing = YES;
    
    if (1 == buttonIndex) {
        imageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imageVC animated:YES completion:nil];
    }
    
}

#pragma mark - 图片选择器代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *editImg = info[UIImagePickerControllerEditedImage];
    _userHeadImage.image = editImg;
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self didFinidhSave];
}
#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id desVC = segue.destinationViewController;
    if ([desVC isKindOfClass:[EditVC class]]) {
        ((EditVC *)desVC).cell = sender;
        ((EditVC *)desVC).delegate = self;
    }
    
}
@end
