//
//  CMDefaultViewTool.m
//  LoanInternalPlus
//
//  Created by wenglx on 2017/10/3.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMDefaultInfoViewTool.h"
#import "CMDefaultInfoView.h"
#import "UIView+JYExtension.h"

#define DefalutViewTag 999

@implementation CMDefaultInfoViewTool

+ (void)showLoadFailureView:(UIView *)view
{
    CMDefaultInfoView *defalutView = [CMDefaultInfoView defaultInfoViewWithFrame:view.bounds imageName:@"loadFailure" title:@"哎呀，出错了" showButton:NO];
    defalutView.center = view.center;
    [view addSubview:defalutView];
}
+ (void)showBorrowNoNetView:(UIView *)view action:(void(^)())reloadActionBlock{
    CMDefaultInfoView *defalutView = [CMDefaultInfoView defaultInfoViewWithFrame:view.bounds imageName:@"Bill_borrowMoney_NotData" title:@"您还没有申请~" showButton:YES];
//    defalutView.center = view.center;
    defalutView.centerX = view.centerX - view.x;
    defalutView.centerY = view.centerY - view.y;
    [defalutView.reloadButton setTitle:@"去申请" forState:UIControlStateNormal];
    defalutView.reloadActionBlock = ^{
        reloadActionBlock();
    };
    [view addSubview:defalutView];
}
+ (void)showNoNetView:(UIView *)view action:(void(^)())reloadActionBlock
{
    CMDefaultInfoView *defalutView = [CMDefaultInfoView defaultInfoViewWithFrame:view.bounds imageName:@"noNet" title:@"网络开小差了～" showButton:YES];
    defalutView.centerX = view.centerX - view.x;
    defalutView.centerY = view.centerY- view.y;
    defalutView.tag = DefalutViewTag;
    [defalutView.reloadButton setTitle:@"立即重试" forState:UIControlStateNormal];
    defalutView.reloadActionBlock = ^{
        reloadActionBlock();
    };
    [view addSubview:defalutView];
}

+ (void)showNoDataView:(UIView *)view action:(void(^)())reloadActionBlock
{
    CMDefaultInfoView *defalutView = [CMDefaultInfoView defaultInfoViewWithFrame:view.bounds imageName:@"noData" title:@"暂无数据" showButton:YES];
    defalutView.centerX = view.centerX - view.x;
    defalutView.centerY = view.centerY- view.y;
    defalutView.tag = DefalutViewTag;
    [defalutView.reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
    defalutView.reloadActionBlock = ^{
        reloadActionBlock();
    };
    [view addSubview:defalutView];
}

+ (void)showNoMessgaeView:(UIView *)view
{
    CMDefaultInfoView *defalutView = [CMDefaultInfoView defaultInfoViewWithFrame:view.bounds imageName:@"noMessage" title:@"亲，你没有收到任何通知" showButton:NO];
    defalutView.center = view.center;
    [view addSubview:defalutView];
}

+ (void)showNoSearchView:(UIView *)view
{
    CMDefaultInfoView *defalutView = [CMDefaultInfoView defaultInfoViewWithFrame:view.bounds imageName:@"noSearch" title:@"亲，没有搜索相关信息" showButton:NO];
    defalutView.center = view.center;
    [view addSubview:defalutView];
}

+ (void)showNoDataView:(UIView *)view
{
    CMDefaultInfoView *defalutView = [CMDefaultInfoView defaultInfoViewWithFrame:view.bounds imageName:@"noData" title:@"没有数据" showButton:NO];
    defalutView.center = view.center;
    [view addSubview:defalutView];
}

+ (void)showNoIndentView:(UIView *)view
{
    CMDefaultInfoView *defalutView = [CMDefaultInfoView defaultInfoViewWithFrame:view.bounds imageName:@"noIndent" title:@"无订单" showButton:NO];
    defalutView.center = view.center;
    [view addSubview:defalutView];
}

+ (void)showNoContentView:(UIView *)view
{
    CMDefaultInfoView *defalutView = [CMDefaultInfoView defaultInfoViewWithFrame:view.bounds imageName:@"noContent" title:@"立即开启网络" showButton:NO];
//    defalutView.center = view.center;
    defalutView.x = 0;
    defalutView.centerY = view.centerY;
    [view addSubview:defalutView];
}

+ (void)dismissFromView:(UIView *)view
{
    for (UIView *defaultInfoView in view.subviews) {
        if ([defaultInfoView isKindOfClass:[CMDefaultInfoView class]]) {
            [defaultInfoView removeFromSuperview];
            return;
        }
    }
}

@end
