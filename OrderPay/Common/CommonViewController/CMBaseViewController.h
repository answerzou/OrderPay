//
//  CMBaseViewController.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMGlobalDef.h"

@interface CMBaseViewController : UIViewController

/**友盟统计相关字段*/
@property (nonatomic, copy)   NSString *umViewControllerName;   //视图名字
@property (nonatomic, assign) BOOL umPageStatistics;            //是否添加友盟页面统计
//------------

- (void)handleBackEvent;
- (void)handleEnterBackground:(NSNotification*)notification;
- (void)handleWillEnterforeground:(NSNotification*)notification;
- (void)handleNetAvailable:(NSNotification*)notification;
- (void)handleNetUnAvailable:(NSNotification*)notification;
- (void)initLeftNavigationItem;
@end
