//
//  CMNotification.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMNotification.h"

@implementation CMNotification
+ (BOOL)post:(NSString*)name object:(id)object userInfo:(NSDictionary *)info;
{
    if (!name || [name length] == 0) return NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:info];
    return YES;
}

+ (BOOL)remove:(id)observer name:(NSString *)name object:(id)object;
{
    if (!name || [name length] == 0) return NO;
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:name object:object];
    return YES;
}

+ (void)remove:(id)observer
{
    if (!observer) return;
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
}

+ (BOOL)add:(id)observer selector:(SEL)aSelector name:(NSString *)name object:(id)object;
{
    if (!name || [name length] == 0) return NO;
    [self remove:observer name:name object:observer];
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector
                                                 name:name object:object];
    return YES;
}
@end
