//
//  UIImage+QRCodeImage.m
//  MyChat
//
//  Created by Mac on 15/9/11.
//  Copyright © 2015年 Zeng. All rights reserved.
//

#import "UIImage+QRCodeImage.h"

@implementation UIImage (QRCodeImage)

#pragma mark - 生成二维码
+ (UIImage *)createQRForString:(NSString *)string{
    if (!string) {
        return nil;
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:string]) {
        return [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:string]];
    }
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    [filter setValue:[string dataUsingEncoding:NSUTF8StringEncoding] forKey:@"inputMessage"];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgimage = [context createCGImage:filter.outputImage fromRect:filter.outputImage.extent];
    UIImage *image = [UIImage imageWithCGImage:cgimage scale:1.0 orientation:UIImageOrientationUp];
    CGImageRelease(cgimage);
    //不失真的放大
    UIImage *resized = [self resizeImage:image withQuality:kCGInterpolationNone rate:5.0];
    //调整长宽比（长宽相等）
    UIImage *QRCodeImage = [self scaleWithFixedWidth:300 image:resized];
    NSData *imageData = UIImagePNGRepresentation(QRCodeImage);
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:string];
    return QRCodeImage;
}

+ (UIImage *)scaleWithFixedWidth:(CGFloat)width image:(UIImage *)image
{
    float newHeight = image.size.height * (width / image.size.width);
    CGSize size = CGSizeMake(width, newHeight);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), image.CGImage);
    
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imageOut;
}

+ (UIImage *)resizeImage:(UIImage *)image
             withQuality:(CGInterpolationQuality)quality
                    rate:(CGFloat)rate
{
    UIImage *resized = nil;
    CGFloat width = image.size.width * rate;
    CGFloat height = image.size.height * rate;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, quality);
    [image drawInRect:CGRectMake(0, 0, width, height)];
    resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resized;
}

@end
