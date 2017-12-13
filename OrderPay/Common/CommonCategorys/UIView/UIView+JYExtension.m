//
//  UIView+JYExtension.m
//  JYFramework
//
//  Created by mcitosh on 2017/7/31.
//  Copyright © 2017年 mcitosh. All rights reserved.
//

#import "UIView+JYExtension.h"

@implementation UIView (JYExtension)
@dynamic x, y, width, height, origin, size;


- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    } else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshot;
}

- (void)removeAllSubviews {
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius maskToBounds:(BOOL)mask {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = mask;
}

- (UIView *)lastSubviewOnX{
    if(self.subviews.count > 0){
        UIView *outView = self.subviews[0];
        
        for(UIView *v in self.subviews)
            if(v.x > outView.x)
                outView = v;
        
        return outView;
    }
    
    return nil;
}

- (UIView *)lastSubviewOnY{
    if(self.subviews.count > 0){
        UIView *outView = self.subviews[0];
        
        for(UIView *v in self.subviews)
            if(v.y > outView.y)
                outView = v;
        
        return outView;
    }
    
    return nil;
}

#pragma mark - Setter Methods
- (void)setX:(CGFloat)x{
    CGRect r        = self.frame;
    r.origin.x      = x;
    self.frame      = r;
}

- (void)setY:(CGFloat)y{
    CGRect r        = self.frame;
    r.origin.y      = y;
    self.frame      = r;
}

/*view 的宽度，X坐标不变，Y坐标实现*/
- (void)setWidth:(CGFloat)width{
    CGRect r        = self.frame;
    r.size.width    = width;
    self.frame      = r;
}


- (void)setHeight:(CGFloat)height{
    CGRect r        = self.frame;
    r.size.height   = height;
    self.frame      = r;
}

- (void)setOrigin:(CGPoint)origin{
    self.x          = origin.x;
    self.y          = origin.y;
}

- (void)setSize:(CGSize)size{
    self.width      = size.width;
    self.height     = size.height;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (void)setTop:(CGFloat)top {
    CGRect frame   = self.frame;
    frame.origin.y = top;
    self.frame     = frame;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    self.layer.shadowRadius = shadowRadius;
}

- (void)setShadowOpacity:(float)shadowOpacity {
    self.layer.shadowOpacity = shadowOpacity;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}

- (void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
}

- (void)setShadowPath:(UIBezierPath *)shadowPath {
    self.layer.shadowPath = shadowPath.CGPath;
}


#pragma mark - Getter Methods
/*view 的X坐标，返回值为float类型,直接调view.x*/
- (CGFloat)x{
    return self.frame.origin.x;
}

/*view 的Y坐标，返回值为float类型,直接调view.y*/
- (CGFloat)y{
    return self.frame.origin.y;
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

/*view 的width，返回值为float类型,直接调view.width*/
- (CGFloat)width{
    return self.frame.size.width;
}

/*view 的height，返回值为float类型,直接调view.height*/
- (CGFloat)height{
    return self.frame.size.height;
}

/*view 的origin，,直接调view.origin 获取*/
- (CGPoint)origin{
    return CGPointMake(self.x, self.y);
}

/*view 的size,直接调view.size 获取*/
- (CGSize)size{
    return CGSizeMake(self.width, self.height);
}

/*view 最右边距X=0 的距离*/
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

/*view 最下边距Y=0 的距离,包含最上免得20像素*/
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (UIColor *)borderColor {
    UIColor *color = [UIColor colorWithCGColor:self.layer.borderColor];
    return color;
}

- (CGFloat)shadowRadius {
    return self.layer.shadowRadius;
}

- (float)shadowOpacity {
    return self.layer.shadowOpacity;
}

- (CGSize)shadowOffset {
    return self.layer.shadowOffset;
}

- (UIColor *)shadowColor {
    UIColor *color = [UIColor colorWithCGColor:self.layer.shadowColor];
    return color;
}

- (UIBezierPath *)shadowPath {
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:self.layer.shadowPath];
    return path;
}
-(void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
    
}
-(void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
    
}
-(void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
    
}
-(void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
}
@end
