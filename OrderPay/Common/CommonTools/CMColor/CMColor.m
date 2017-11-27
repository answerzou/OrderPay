//
//  CMColor.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMColor.h"

static const CGFloat redDivisor = 255;
static const CGFloat greenDivisor = 255;
static const CGFloat blueDivisor = 255;

static const CGFloat hueDivisor = 360;
static const CGFloat saturationDivisor = 100;
static const CGFloat brightnessDivisor = 100;

static const CGFloat whiteDivisor = 100;
static const CGFloat alphaDivisor = 100;

#define ADD_RED_MASK        0xFF0000
#define ADD_GREEN_MASK      0xFF00
#define ADD_BLUE_MASK       0xFF
#define ADD_ALPHA_MASK      0xFF000000
#define ADD_COLOR_SIZE      255.0
#define ADD_RED_SHIFT       16
#define ADD_GREEN_SHIFT     8
#define ADD_BLUE_SHIFT      0
#define ADD_ALPHA_SHIFT     24


@implementation UIColor (Integers)

#pragma mark --
#pragma mark Grayscale
+ (instancetype)colorWithIntegerWhite:(NSUInteger)white
{
    return [self colorWithIntegerWhite:white
                                 alpha:alphaDivisor];
}

+ (instancetype)colorWithIntegerWhite:(NSUInteger)white alpha:(NSUInteger)alpha
{
    return [self colorWithWhite:white/whiteDivisor
                          alpha:alpha/alphaDivisor];
}


#pragma mark --
#pragma mark RGB
+ (instancetype)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue
{
    return [self colorWithIntegerRed:red
                               green:green
                                blue:blue
                               alpha:alphaDivisor];
}

+ (instancetype)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(NSUInteger)alpha
{
    return [self colorWithRed:red/redDivisor
                        green:green/greenDivisor
                         blue:blue/blueDivisor
                        alpha:alpha/alphaDivisor];
}


#pragma mark --
#pragma mark HSB
+ (instancetype)colorWithIntegerHue:(NSUInteger)hue saturation:(NSUInteger)saturation brightness:(NSUInteger)brightness
{
    return [self colorWithIntegerHue:hue
                          saturation:saturation
                          brightness:brightness
                               alpha:alphaDivisor];
}

+ (instancetype)colorWithIntegerHue:(NSUInteger)hue saturation:(NSUInteger)saturation brightness:(NSUInteger)brightness alpha:(NSUInteger)alpha
{
    return [self colorWithHue:hue/hueDivisor
                   saturation:saturation/saturationDivisor
                   brightness:brightness/brightnessDivisor
                        alpha:alpha/alphaDivisor];
}


#pragma mark - 渐变色
+ (UIView *)navBackgroudView{
    UIView *navBackgroudView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    [navBackgroudView.layer addSublayer:[self getGraduallyChangingColorLayerWithFrame:navBackgroudView.bounds]];
    return navBackgroudView;
}

+ (CAGradientLayer *)getLockViewGraduallyChangingColorLayerWithFrame:(CGRect)frame{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[self colorWithHexString:@"51CEBF"].CGColor, (__bridge id)[self colorWithHexString:@"51B0F6"].CGColor, (__bridge id)[self colorWithHexString:@"BF94FF"].CGColor];
    gradientLayer.locations = @[@0, @0.4, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = frame;
    return gradientLayer;
}


/**
 判断textfield是否超过最大字符
 
 @param maxLenth 最大字符数
 @param textField textfield
 */
+ (void)checkTextLenth:(NSInteger)maxLenth TextField:(UITextField *)textField{
    if (maxLenth == 0) {
        return;
    }
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > maxLenth)
            {
                textField.text = [toBeString substringToIndex:maxLenth];
            }
        }
        
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > maxLenth)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLenth];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:maxLenth];
            }
            else
            {
                //                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"最多输入%ld个字",maxLenth] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                //                [alertView show];
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLenth)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
    
}

+ (CAGradientLayer *)getGraduallyChangingColorLayerWithFrame:(CGRect)frame{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[self colorWithHexString:@"51CEBF"].CGColor, (__bridge id)[self colorWithHexString:@"51B0F6"].CGColor, (__bridge id)[self colorWithHexString:@"BF94FF"].CGColor];
    gradientLayer.locations = @[@0, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = frame;
    return gradientLayer;
}
+ (CAGradientLayer *)getSettingViewGraduallyChangingColorLayerWithFrame:(CGRect)frame
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[self colorWithHexString:@"0C9BFF"].CGColor, (__bridge id)[self colorWithHexString:@"4DA3FF"].CGColor];
    gradientLayer.locations = @[@0.3, @.7];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = frame;
    return gradientLayer;
}
+ (UIColor *) lineColor{
    return [self colorWithHexString:@"C9C8C9"];
}
+ (UIColor *)blueTextColor{
    return [self colorWithHexString:@"#4a90e2"];
}
+ (UIColor *) textGrayColor{
    return [self colorWithHexString:@"#9b9b9b"];
}
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}



@end

///////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation UIColor (Hex)
+ (instancetype)colorWithRGBHexValue:(NSUInteger)rgbHexValue
{
    return [UIColor colorWithRed:((CGFloat)((rgbHexValue & ADD_RED_MASK) >> ADD_RED_SHIFT))/ADD_COLOR_SIZE
                           green:((CGFloat)((rgbHexValue & ADD_GREEN_MASK) >> ADD_GREEN_SHIFT))/ADD_COLOR_SIZE
                            blue:((CGFloat)((rgbHexValue & ADD_BLUE_MASK) >> ADD_BLUE_SHIFT))/ADD_COLOR_SIZE
                           alpha:1.0];
}

+ (instancetype)colorWithRGBAHexValue:(NSUInteger)rgbaHexValue
{
    return [UIColor colorWithRed:((CGFloat)((rgbaHexValue & ADD_RED_MASK) >> ADD_RED_SHIFT))/ADD_COLOR_SIZE
                           green:((CGFloat)((rgbaHexValue & ADD_GREEN_MASK) >> ADD_GREEN_SHIFT))/ADD_COLOR_SIZE
                            blue:((CGFloat)((rgbaHexValue & ADD_BLUE_MASK) >> ADD_BLUE_SHIFT))/ADD_COLOR_SIZE
                           alpha:((CGFloat)((rgbaHexValue & ADD_ALPHA_MASK) >> ADD_ALPHA_SHIFT))/ADD_COLOR_SIZE];
}

+ (instancetype)colorWithRGBHexString:(NSString*)rgbHexString
{
    NSUInteger rgbHexValue;
    
    NSScanner* scanner = [NSScanner scannerWithString:rgbHexString];
    BOOL successful = [scanner scanHexInt:(unsigned *)&rgbHexValue];
    
    if (!successful)
        return nil;
    
    return [self colorWithRGBHexValue:rgbHexValue];
}

+ (instancetype)colorWithRGBAHexString:(NSString*)rgbaHexString
{
    NSUInteger rgbHexValue;
    
    NSScanner *scanner = [NSScanner scannerWithString:rgbaHexString];
    BOOL successful = [scanner scanHexInt:(unsigned *)&rgbHexValue];
    
    if (!successful)
        return nil;
    
    return [self colorWithRGBAHexValue:rgbHexValue];
}
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString {
    if ([hexColorString length] <6) {//长度不合法
        return [UIColor blackColor];
    }
    NSString *tempString=[hexColorString lowercaseString];
    if ([tempString hasPrefix:@"0x"]) {//检查开头是0x
        tempString = [tempString substringFromIndex:2];
    }else if ([tempString hasPrefix:@"#"]) {//检查开头是#
        tempString = [tempString substringFromIndex:1];
    }
    if ([tempString length] !=6) {
        return [UIColor blackColor];
    }
    //分解三种颜色的值
    NSRange range;
    range.location =0;
    range.length =2;
    NSString *rString = [tempString substringWithRange:range];
    range.location =2;
    NSString *gString = [tempString substringWithRange:range];
    range.location =4;
    NSString *bString = [tempString substringWithRange:range];
    //取三种颜色值
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString]scanHexInt:&r];
    [[NSScanner scannerWithString:gString]scanHexInt:&g];
    [[NSScanner scannerWithString:bString]scanHexInt:&b];
    return [UIColor colorWithRed:((float) r /255.0f)
                           green:((float) g /255.0f)
                            blue:((float) b /255.0f)
                           alpha:1.0f];
}

- (BOOL)getRGBHexValue:(NSUInteger*)rgbHex
{
    size_t numComponents = CGColorGetNumberOfComponents(self.CGColor);
    CGFloat const * components = CGColorGetComponents(self.CGColor);
    
    if (numComponents == 4){
        CGFloat rFloat = components[0]; // red
        CGFloat gFloat = components[1]; // green
        CGFloat bFloat = components[2]; // blue
        
        NSUInteger r = (NSUInteger)roundf(rFloat*ADD_COLOR_SIZE);
        NSUInteger g = (NSUInteger)roundf(gFloat*ADD_COLOR_SIZE);
        NSUInteger b = (NSUInteger)roundf(bFloat*ADD_COLOR_SIZE);
        
        *rgbHex = (r << ADD_RED_SHIFT) + (g << ADD_GREEN_SHIFT) + (b << ADD_BLUE_SHIFT);
        
        return YES;
    }
    else if (numComponents == 2){
        CGFloat gFloat = components[0]; // gray
        NSUInteger g = (NSUInteger)roundf(gFloat*ADD_COLOR_SIZE);
        *rgbHex = (g << ADD_RED_SHIFT) + (g << ADD_GREEN_SHIFT) + (g << ADD_BLUE_SHIFT);
        return YES;
    }
    
    return NO;
}

- (BOOL)getRGBAHexValue:(NSUInteger*)rgbaHex;
{
    size_t numComponents = CGColorGetNumberOfComponents(self.CGColor);
    CGFloat const * components = CGColorGetComponents(self.CGColor);
    
    if (numComponents == 4){
        CGFloat rFloat = components[0]; // red
        CGFloat gFloat = components[1]; // green
        CGFloat bFloat = components[2]; // blue
        CGFloat aFloat = components[3]; // alpha
        
        NSUInteger r = (NSUInteger)roundf(rFloat*ADD_COLOR_SIZE);
        NSUInteger g = (NSUInteger)roundf(gFloat*ADD_COLOR_SIZE);
        NSUInteger b = (NSUInteger)roundf(bFloat*ADD_COLOR_SIZE);
        NSUInteger a = (NSUInteger)roundf(aFloat*ADD_COLOR_SIZE);
        
        *rgbaHex = (r << ADD_RED_SHIFT) + (g << ADD_GREEN_SHIFT) + (b << ADD_BLUE_SHIFT) + (a << ADD_ALPHA_SHIFT);
        
        return YES;
    }
    else if (numComponents == 2){
        CGFloat gFloat = components[0]; // gray
        CGFloat aFloat = components[1]; // alpha
        
        NSUInteger g = (NSUInteger)roundf(gFloat*ADD_COLOR_SIZE);
        NSUInteger a = (NSUInteger)roundf(aFloat *ADD_COLOR_SIZE);
        
        *rgbaHex = (g << ADD_RED_SHIFT) + (g << ADD_GREEN_SHIFT) + (g << ADD_BLUE_SHIFT) + (a << ADD_ALPHA_SHIFT);
        
        return YES;
    }
    
    return NO;
}

- (NSString*)stringWithRGBHex
{
    NSUInteger value = 0;
    BOOL compatible = [self getRGBHexValue:&value];
    
    if (!compatible)
        return nil;
    
    return [NSString stringWithFormat:@"%x", (unsigned)value];
}

- (NSString*)stringWithRGBAHex
{
    NSUInteger value = 0;
    BOOL compatible = [self getRGBAHexValue:&value];
    
    if (!compatible)
        return nil;
    
    return [NSString stringWithFormat:@"%x", (unsigned)value];
}
@end

@implementation CMColor

@end

