//
//  UIButton+JYExtension.h
//  LoanInternalPlus
//
//  Created by wenglx on 2017/8/30.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, JYImagePosition) {
    JYImagePositionLeft = 0,              //图片在左，文字在右，默认
    JYImagePositionRight = 1,             //图片在右，文字在左
    JYImagePositionTop = 2,               //图片在上，文字在下
    JYImagePositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (JYExtension)
/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(JYImagePosition)postion spacing:(CGFloat)spacing;

@end
