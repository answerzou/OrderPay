//
//  CMToast.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/16.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMToast.h"

@implementation CMToast
+ (UIWindow*)creatShowTipWindow
{
    return [[[UIApplication sharedApplication] delegate] window];
}

/**
 *reference:show message in window
 *parameters:toast(message),delegate(delegate)
 *return:null
 */
+ (void)showToast:(NSString*)toast delegate:(id)delegate
{
    if (toast.length == 0) return;
    
    UIWindow* tipWindow = [self creatShowTipWindow];
    MBProgressHUD* hud =  [[MBProgressHUD alloc] initWithWindow:tipWindow];
    [tipWindow addSubview:hud];
    
    // Set custom view mode
    hud.mode = MBProgressHUDModeText;
    hud.delegate = delegate;
    hud.detailsLabelText = toast;
    hud.detailsLabelFont = [UIFont systemFontOfSize:16.0f];
    hud.removeFromSuperViewOnHide = YES;
    
    [hud show:YES];
    [hud hide:YES afterDelay:1.5f];
}

/**
 *reference:show message in special view
 *parameters:toast(message),delegate(delegate),inView(special view)
 *return:null
 */
+ (void)showToast:(NSString*)toast inView:(UIView*)inView delegate:(id)delegate
{
    if (toast.length == 0) return;
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:inView];
    [inView addSubview:hud];
    
    // Set custom view mode
    hud.mode = MBProgressHUDModeText;
    hud.delegate = delegate;
    hud.detailsLabelText = toast;
    hud.detailsLabelFont = [UIFont systemFontOfSize:16.0f];
    hud.removeFromSuperViewOnHide = YES;
    
    [hud show:YES];
    [hud hide:YES afterDelay:1.5f];
}

/**
 *reference:show waiting indicator
 *parameters:toast(message),delegate(delegate)
 *return:null
 */
+ (MBProgressHUD*)showWaiting:(NSString*)toast delegate:(id)delegate
{
    UIWindow* tipWindow = [self creatShowTipWindow];
    MBProgressHUD* hud =  [[MBProgressHUD alloc] initWithWindow:tipWindow];
    [tipWindow addSubview:hud];
    
    // Set custom view mode
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.delegate = delegate;
    hud.detailsLabelText = toast;
    hud.detailsLabelFont = [UIFont systemFontOfSize:16.0f];
    hud.removeFromSuperViewOnHide = YES;
    
    [hud show:YES];
    return hud;
}
@end

