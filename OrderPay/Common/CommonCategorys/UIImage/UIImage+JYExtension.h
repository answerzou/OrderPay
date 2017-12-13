//
//  UIImage+JYExtension.h
//  LoanInternalPlus
//
//  Created by wenglx on 2017/8/30.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JYExtension)
/**
 * 渲染为原始图片
 */
+ (UIImage *)jy_imageWithRenderingImage:(NSString *)imageName;

/**
 * 颜色转为图片
 */
+ (UIImage *)jy_imageWithColor:(UIColor *)color;

/**
 * 颜色转为图片
 */
+ (UIImage *)jy_imageWithColor:(UIColor *)color andSize:(CGSize)size;

@end
