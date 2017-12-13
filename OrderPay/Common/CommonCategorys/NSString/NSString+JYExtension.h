//
//  NSString+JYExtension.h
//  LoanInternalPlus
//
//  Created by leipeng on 2017/6/22.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JYExtension)
/**判断字符串是否为空*/
- (BOOL)isNoEmpty;

/** 处理数字类型 
 *  str:   需要处理的数据
 *  type:  元/期
 */
+ (NSString *)numberFormateWith:(NSString *)str addType:(NSString *)type;
@end
