//
//  CMView.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CMView : NSObject
@end
@interface UIView (Ext)

@property(nonatomic, assign)CGFloat         left;
@property(nonatomic, assign)CGFloat         top;
@property(nonatomic, assign)CGFloat         right;
@property(nonatomic, assign)CGFloat         bottom;
@property(nonatomic, assign)CGFloat         width;
@property(nonatomic, assign)CGFloat         height;
@property(nonatomic, assign)CGSize          size;
@property(nonatomic, assign)CGPoint         origin;

- (void)removeAllSubviews;
+(CGRect)frameWithW:(CGFloat)w h:(CGFloat)h center:(CGPoint)center;
@end
