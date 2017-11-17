//
//  CMNotification.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMNotification : NSObject
/**
 *reference:post notification
 *parameters:info,name,object
 *return:yes or no
 */
+ (BOOL)post:(NSString*)name object:(id)object userInfo:(NSDictionary*)info;

/**
 *reference:remove notification
 *parameters:observer,name,object
 *return:yes or no
 */
+ (BOOL)remove:(id)observer name:(NSString*)name object:(id)object;
+ (void)remove:(id)observer;
/**
 *reference:add notification
 *parameters:observer,aSelector,name,object
 *return:yes or no
 */
+ (BOOL)add:(id)observer selector:(SEL)aSelector name:(NSString*)name object:(id)object;

@end
