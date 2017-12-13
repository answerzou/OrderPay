//
//  NSString+JYExtension.m
//  LoanInternalPlus
//
//  Created by leipeng on 2017/6/22.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "NSString+JYExtension.h"

@implementation NSString (JYExtension)
- (BOOL)isNoEmpty{
    if ([self isEqualToString:@""]) {
        return NO;
    }else if (self == nil){
        return NO;
    }else if (self.length ==0){
        return NO;
    }
    return YES;
}

/** 处理数字类型
 *  str:   需要处理的数据
 *  type:  元/期
 */
+ (NSString *)numberFormateWith:(NSString *)str addType:(NSString *)type{
    if (type == nil) {
        type = @"";
    }
    if (str == nil) {
        return [NSString stringWithFormat:@"0%@",type];
    }else if([str rangeOfString:@"."].location == NSNotFound){
        return [NSString stringWithFormat:@"%@%@",str,type];
    }else if([str rangeOfString:@"."].location != NSNotFound){
        return [NSString stringWithFormat:@"%.2f%@",[str floatValue],type];
    }else{
        return [NSString stringWithFormat:@"%@%@",str,type];
    }
}

@end
