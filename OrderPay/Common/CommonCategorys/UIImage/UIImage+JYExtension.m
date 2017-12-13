//
//  UIImage+JYExtension.m
//  LoanInternalPlus
//
//  Created by wenglx on 2017/8/30.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "UIImage+JYExtension.h"

@implementation UIImage (JYExtension)

+ (UIImage *)jy_imageWithRenderingImage:(NSString *)imageName
{
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)jy_imageWithColor:(UIColor *)color
{
    return [UIImage jy_imageWithColor:color andSize:CGSizeMake(1, 1)];
}

+ (UIImage *)jy_imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
