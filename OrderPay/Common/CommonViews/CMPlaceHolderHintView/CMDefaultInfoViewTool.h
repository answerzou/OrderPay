//
//  CMDefaultViewTool.h
//  LoanInternalPlus
//
//  Created by wenglx on 2017/10/3.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CMDefaultInfoViewTool : NSObject

+ (void)showLoadFailureView:(UIView *)view;
+ (void)showNoNetView:(UIView *)view action:(void(^)(void))reloadActionBlock;
+ (void)showNoDataView:(UIView *)view action:(void(^)(void))reloadActionBlock;
+ (void)showNoMessgaeView:(UIView *)view;
+ (void)showNoSearchView:(UIView *)view;
+ (void)showNoDataView:(UIView *)view;
+ (void)showNoIndentView:(UIView *)view;
+ (void)showNoContentView:(UIView *)view;

+ (void)dismissFromView:(UIView *)view;
+ (void)showBorrowNoNetView:(UIView *)view action:(void(^)())reloadActionBlock;
@end
