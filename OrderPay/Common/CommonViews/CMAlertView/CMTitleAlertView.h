//
//  CMAlertView.h
//  JYCashLoan
//
//  Created by leipeng on 2017/11/8.
//  Copyright © 2017年 jieyue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMTitleAlertView : UIView

/**
 显示alert
 
 @param aString 显示的标题
 @param completion 回调
 */
+ (void)showWithTitle:(NSString *)aString completion:(void(^)(NSInteger selectIndex))completion;

/**
 取消的index
 */
@property (nonatomic, assign) NSInteger cancelIndex;
@end
