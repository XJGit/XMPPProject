//
//  AlertView.m
//  MyChat
//
//  Created by Mac on 15/9/7.
//  Copyright (c) 2015年 Zeng. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

+ (instancetype)initInstance{
    AlertView *aletr = [[self alloc] init];
    return aletr;
}

#pragma mark - 显示提醒视图
- (void)showWithMessage:(NSString *)message{
    self.text = message;
    [self sizeToFit];
    self.textColor = [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1];
    self.center = CGPointMake([[UIApplication sharedApplication].delegate window].center.x, [[UIApplication sharedApplication].delegate window].bounds.size.height / 3 * 2);
    self.alpha = 0;
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(clearSelf) userInfo:nil repeats:NO];
    }];
}

- (void)clearSelf{
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
