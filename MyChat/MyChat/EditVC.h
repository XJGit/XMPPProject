//
//  EditVC.h
//  MyChat
//
//  Created by Mac on 15/9/11.
//  Copyright © 2015年 Zeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditVCDelegate;

@interface EditVC : UITableViewController

/**
 * 上一个控制器被选中的cell
 */
@property (nonatomic, strong)UITableViewCell *cell;

@property (nonatomic, weak)id<EditVCDelegate> delegate;

@end

@protocol EditVCDelegate <NSObject>

- (void)didFinidhSave;

@end