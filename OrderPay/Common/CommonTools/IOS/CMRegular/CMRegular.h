//
//  CMRegular.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMRegular : NSObject
#define FEED_CONTENT_AT     @"(@[\u4e00-\u9fa5a-zA-Z0-9_-]{4,30})"
#define FEED_CONTENT_TAG    @"(#[^#]+#)"
#define CMT_CONTENT_EMOJI  @"\\[(.*?)\\]"


typedef NS_ENUM(NSUInteger, CheckFormatType)
{
    CheckFormatTypeEmail,
    CheckFormatTypePassword,
    CheckFormatTypeMoney,
    CheckFormatTypeURL,
    CheckFormatTypePhone,
    CheckFormatTypeAT,
    CheckFormatTypeTAG,
    CheckFormatTypeOwnEmoji,
    CheckFormatTypeSearchKey,
    CheckFormatTypeSpecialCharacter,
};
+ (BOOL)isValidatePassport:(NSString *)passport;
+ (BOOL)isValidateRefundName:(NSString *)name;
+ (BOOL)isValidateFormat:(NSString*)format type:(CheckFormatType)type;
+ (BOOL)checkEmoji:(NSString*)string;
+ (NSString*)trimSpace4String:(NSString*)input;
+ (NSString*)reverseString:(NSString*)input;
+ (NSString*)currencyFormatWithString:(NSString*)input prefix:(NSString*)prefix;
+ (NSString*)currencyFormatWithNumber:(NSNumber*)input  prefix:(NSString*)prefix;
+ (NSNumber*)currencyFormatWithNString:(NSString*)string;
+ (double)currencyFormatWithNumber:(NSNumber*)number bits:(NSInteger)bits;
+ (BOOL)checkUrl:(NSString *)string;
@end
