//
//  CMNoMessageView.h
//  LoanInternalPlus
//
//  Created by wenglx on 2017/10/3.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMDefaultInfoView : UIView

+ (instancetype)defaultInfoViewWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title showButton:(BOOL)isShow;

/** 图片 */
@property (nonatomic, strong) UIImageView *imageView;
/** 提示语 */
@property (nonatomic, strong) UILabel *hintLabel;
/** 事件按钮 */
@property (nonatomic, strong) UIButton *reloadButton;
/** 事件 */
@property (nonatomic, copy) void(^reloadActionBlock)();
@end
