//
//  AlertView.h
//  MyChat
//
//  Created by Mac on 15/9/7.
//  Copyright (c) 2015年 Zeng. All rights reserved.
//

/**
 * 说明：本类继承UILabel，用做提醒视图
 */

#import <UIKit/UIKit.h>

@interface AlertView : UILabel
/**
 * 类方法创建一个实例
 */
+ (instancetype)initInstance;
/**
 * show出提醒视图
 * @param 提醒信息
 */
- (void)showWithMessage:(NSString *)message;
@end
