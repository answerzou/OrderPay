//
//  UILabel+JYExtension.h
//  JYFramework
//
//  Created by mcitosh on 2017/7/31.
//  Copyright © 2017年 mcitosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (JYExtension)

/**
 *  整数从0开始计时加
 *
 *  @param originalnumber <#originalnumber description#>
 *  @param newNumber      <#newNumber description#>
 */
- (void)scrollDigitalFromIntNumber:(int)originalnumber toNewIntNumber:(int)newNumber;

/**
 *  滚动数字
 *
 *  @param originalnumber <#originalnumber description#>
 *  @param newNumber      <#newNumber description#>
 *  @param type           type=0 仅滚动数字  type=1 数字滚动完成之后数字格式化
 */
- (void)scrollDigitalFromDoubleNumber:(double)originalnumber toNewDoubleNumber:(double)newNumber withType:(NSInteger)type;

-(void)stopTimer;

@end
