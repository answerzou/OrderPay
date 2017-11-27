//
//  JYCitySelectManager.h
//  JYCashLoan
//
//  Created by Kim on 2017/11/14.
//  Copyright © 2017年 jieyue. All rights reserved.
//
/**   用法
 [[JYCitySelectManager sharedInstance] showInView:^(NSString *cityName) {
 NSLog(@"选择的城市是：%@",cityName);
 }];
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIWindow.h>

typedef void(^FinishCitySelect)(NSString *cityName);

@interface JYCitySelectManager : NSObject

@property (nonatomic, strong) UIWindow *bgWindow;

+ (instancetype)sharedInstance;

//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(FinishCitySelect)cityName;

@end
