//
//  NSURLSessionTask+UserInfo.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/16.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "NSURLSessionTask+UserInfo.h"
#import <objc/runtime.h>

@implementation NSURLSessionTask (UserInfo)

static const char *TaskUserinfo = "TaskUserinfo";

- (void)setUserinfo:(NSMutableDictionary *)userinfo
{
      objc_setAssociatedObject(self, TaskUserinfo, userinfo, OBJC_ASSOCIATION_RETAIN);
}
- (NSMutableDictionary*)userinfo
{
    return objc_getAssociatedObject(self, TaskUserinfo);
}
@end
