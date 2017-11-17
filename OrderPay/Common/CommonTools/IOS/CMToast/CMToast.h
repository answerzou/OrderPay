//
//  CMToast.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/16.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CMToolsDef.h"
#define CMToast(toast)    {[CMToast showToast:toast delegate:nil];}
#define CMToastEx(toast,view)    {[CMToast showToast:toast inView:view delegate:nil];}

@interface CMToast : NSObject
/**
 *reference:show message in window
 *parameters:toast(message),delegate(delegate)
 *return:null
 */
+ (void)showToast:(NSString*)toast delegate:(id)delegate;

/**
 *reference:show message in special view
 *parameters:toast(message),delegate(delegate),inView(special view)
 *return:null
 */
+ (void)showToast:(NSString*)toast inView:(UIView*)inView delegate:(id)delegate;

/**
 *reference:show waiting indicator
 *parameters:toast(message),delegate(delegate)
 *return:null
 */
+ (MBProgressHUD*)showWaiting:(NSString*)toast delegate:(id)delegate;

@end
