//
//  CMIdentifier.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CM_IDENTIFIER_ID                @"cr_identifier_id"
#define CM_IDENTIFIER_COMPANY           @"com.jieyuechina.loaninternal.id"
@interface CMIdentifier : NSObject
+ (NSString*)platform;

/**
 *reference:hash string for mac address
 *parameters:nil
 *return:mac address identifier
 */
+ (NSString*)appMacIdentifier;

/**
 *reference:hash string for mac address and bundle id
 *parameters:nil
 *return:global identifier
 */
+ (NSString*)appGlobalIdentifier;

/**
 *reference:store identifier to userdefault
 *parameters:iden string
 *return:yes or no
 */
+ (BOOL)storeDefaultIdentifier:(NSString*)iden;

/**
 *reference:get identifier from userdefault
 *parameters:nil
 *return:default identifier
 */
+ (NSString*)loadDefaultIdentifier;

/**
 *reference:store identifier to userdefault
 *parameters:iden string
 *return:yes or no
 */
+ (BOOL)storeKeyChainIdentifier:(NSString*)iden;

/**
 *reference:get identifier from userdefault
 *parameters:nil
 *return:identifier string
 */
+ (NSString*)loadKeyChainIdentifier;

/**
 *reference:get a uuid
 *parameters:nil
 *return:uuid string
 */
+ (NSString*)generateUUIDString;

@end
