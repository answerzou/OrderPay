//
//  CMView.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMView.h"

@implementation UIView (Ext)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    self.frame = CGRectMake(left, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top
{
    self.frame = CGRectMake(self.frame.origin.x, top, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGFloat currentRight = self.frame.origin.x + self.frame.size.width;
    CGFloat offx = right - currentRight;
    self.frame = CGRectMake(self.frame.origin.x + offx, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGFloat currentBottom = self.frame.origin.y + self.frame.size.height;
    CGFloat offy = bottom - currentBottom;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + offy, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    self.frame = CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)removeAllSubviews
{
    for (UIView *view in self.subviews){
        [view removeFromSuperview];
    }
}

+(CGRect)frameWithW:(CGFloat)w h:(CGFloat)h center:(CGPoint)center
{
    
    CGFloat x = center.x - w *.5f;
    CGFloat y = center.y - h * .5f;
    CGRect frame = (CGRect){CGPointMake(x, y),CGSizeMake(w, h)};
    
    return frame;
}
@end


@implementation CMView
@end

