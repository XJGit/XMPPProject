//
//  UIImage+QRCodeImage.h
//  MyChat
//
//  Created by Mac on 15/9/11.
//  Copyright © 2015年 Zeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCodeImage)

+ (UIImage *)createQRForString:(NSString *)string;

@end
