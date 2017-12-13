//
//  UIView+JYExtension.h
//  JYFramework
//
//  Created by mcitosh on 2017/7/31.
//  Copyright © 2017年 mcitosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JYExtension)

/** view 的X */
@property (nonatomic, assign) CGFloat   x;
/** View.Y*/
@property (nonatomic, assign) CGFloat   y;
/** view.maxX */
@property (nonatomic, assign,readonly) CGFloat   maxX;
/** View.maxY*/
@property (nonatomic, assign,readonly) CGFloat   maxY;
/** View.width */
@property (nonatomic, assign) CGFloat   width;
/** View.height */
@property (nonatomic, assign) CGFloat   height;
/** View's origin - Sets X and Y Positions */
@property (nonatomic, assign) CGPoint   origin;
/** View's size - Sets Width and Height */
@property (nonatomic, assign) CGSize    size;
/** View.top **/
@property (nonatomic, assign) CGFloat   top;
/** view最下边到Y==0的距离 ，包含最上边的20像素 **/
@property (nonatomic, assign) CGFloat   bottom;
/** view最右边到X==0的距离 **/
@property (nonatomic, assign) CGFloat   right;
/** View.centerX **/
@property (nonatomic, assign) CGFloat   centerX;
/** view.centerY **/
@property (nonatomic, assign) CGFloat   centerY;
/** cornerRadius **/
@property (nonatomic, assign) CGFloat   cornerRadius;
/** borderWidth **/
@property (nonatomic, assign) CGFloat   borderWidth;
/** shadowOpacity **/
@property (nonatomic, assign) float shadowOpacity;
/** shadowRadius **/
@property (nonatomic, assign) CGFloat   shadowRadius;

@property (nonatomic) CGSize shadowOffset;

@property (nonatomic) UIColor *shadowColor;

@property (nonatomic) UIBezierPath *shadowPath;
/** borderColor **/
@property (nonatomic) UIColor *borderColor;
/** 子视图在父视图中X的相对位置 **/
@property (nonatomic, strong, readonly) UIView *lastSubviewOnX;
/** 子视图在父视图中Y的相对位置 **/
@property (nonatomic, strong, readonly) UIView *lastSubviewOnY;

- (UIImage *)snapshotImage;
- (void)setCornerRadius:(CGFloat)cornerRadius maskToBounds:(BOOL)mask;
- (void)removeAllSubviews;


-(void)addBottomBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
-(void)addLeftBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
-(void)addRightBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
-(void)addTopBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;  
@end
