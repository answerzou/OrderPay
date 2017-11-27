//
//  CMColor.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGBC         [UIColor clearColor]
#define RGBS(x,a)    [UIColor colorWithWhite:x/255.0f alpha:a]
#define HRGB(a)      [UIColor colorWithRGBHexString:a]
#define HRGBA(a)     [UIColor colorWithRGBAHexString:a]

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define COLOR(NAME, OBJECT) + (instancetype)NAME {\
static UIColor *_NAME;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_NAME = OBJECT;\
});\
return _NAME;\
}\

@interface UIColor (Integers)
+ (instancetype)colorWithIntegerWhite:(NSUInteger)white;
+ (instancetype)colorWithIntegerWhite:(NSUInteger)white alpha:(NSUInteger)alpha;

+ (instancetype)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;
+ (instancetype)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha;

+ (instancetype)colorWithIntegerHue:(NSUInteger)hue saturation:(NSUInteger)saturation brightness:(NSUInteger)brightness;
+ (instancetype)colorWithIntegerHue:(NSUInteger)hue saturation:(NSUInteger)saturation brightness:(NSUInteger)brightness alpha:(NSUInteger)alpha;


/**
 导航栏下的背景颜色
 */
+(UIView *)navBackgroudView;
/**
 手势解锁界面
 
 @param frame 手势解锁的渐变layer
 @return 渐变色的layer
 */
+ (CAGradientLayer *)getLockViewGraduallyChangingColorLayerWithFrame:(CGRect)frame;
/**
 设置渐变色
 
 @param frame 渐变的layer大小
 @return 渐变色的layer
 */
+ (CAGradientLayer *)getGraduallyChangingColorLayerWithFrame:(CGRect)frame;

/**
 设置侧滑界面的渐变色
 
 @param frame 渐变的layer大小
 @return 渐变色的layer
 */
+ (CAGradientLayer *)getSettingViewGraduallyChangingColorLayerWithFrame:(CGRect)frame;

/**
 蓝色字体颜色
 */
+ (UIColor *) blueTextColor;
/**
 灰色颜色字体
 */
+ (UIColor *) textGrayColor;
/**
 线的颜色
 
 @return 线的颜色
 */
+ (UIColor *) lineColor;

/**
 判断textfield是否超过最大字符
 
 @param maxLenth 最大字符数
 @param textField textfield
 */
+ (void)checkTextLenth:(NSInteger)maxLenth TextField:(UITextField *)textField;


@end

@interface UIColor (Hex)
+ (instancetype)colorWithRGBHexValue:(NSUInteger)rgbHexValue;
+ (instancetype)colorWithRGBAHexValue:(NSUInteger)rgbaHexValue;
+ (instancetype)colorWithRGBHexString:(NSString*)rgbHexString;
+ (instancetype)colorWithRGBAHexString:(NSString*)rgbaHexString;
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString;
- (NSString*)stringWithRGBHex;
- (NSString*)stringWithRGBAHex;
@end
@interface CMColor : NSObject

@end
