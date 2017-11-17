//
//  CMPinyin.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMPinyin.h"

@implementation CMPinyin
- (NSString*)pinYin
{
    NSMutableString*str = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)str,NULL,kCFStringTransformMandarinLatin,NO);
    CFStringTransform((CFMutableStringRef)str,NULL,kCFStringTransformStripDiacritics,NO);
    return str;
}

- (NSString*)firstCharactor
{
    NSString*pinYin = [self.pinYin uppercaseString];
    return[pinYin substringToIndex:1];
}

@end
