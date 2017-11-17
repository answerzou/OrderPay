//
//  CMRegular.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMRegular.h"

@implementation CMRegular
+ (BOOL)isValidatePassport:(NSString *)passport
{
    NSString *nameRegex = @"^[a-zA-Z ]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [phoneTest evaluateWithObject:passport];
}
+ (BOOL)isValidateRefundName:(NSString *)name
{
    NSString *nameRegex = @"^[\u4e00-\u9fa5a-zA-Z0-9_-]+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [phoneTest evaluateWithObject:name];
}
+ (NSString*)trimSpace4String:(NSString*)input
{
    return [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+ (NSString*)reverseString:(NSString*)input
{
    NSUInteger len = [input length];
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:len];
    for (NSInteger i = len - 1; i >= 0; i--) {
        [result appendFormat:@"%c", [input characterAtIndex:i]];
    }
    return result;
}

+ (NSString*)currencyFormatWithString:(NSString*)input prefix:(NSString*)prefix
{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:[NSLocale systemLocale]];
    NSMutableString *formatString = [NSMutableString stringWithString:[numberFormatter stringFromNumber:@([input doubleValue])]];
    [formatString replaceCharactersInRange:NSMakeRange(0, 1) withString:prefix?prefix:@""];
    return formatString;
}

+ (NSString*)currencyFormatWithNumber:(NSNumber*)number  prefix:(NSString*)prefix
{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:[NSLocale systemLocale]];
    NSMutableString *formatString = [NSMutableString stringWithString:[numberFormatter stringFromNumber:number]];
    [formatString replaceCharactersInRange:NSMakeRange(0, 1) withString:prefix?prefix:@""];
    return formatString;
}
+ (NSNumber*)currencyFormatWithNString:(NSString*)string
{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [numberFormatter numberFromString:string];
}

+ (double)currencyFormatWithNumber:(NSNumber*)number bits:(NSInteger)bits
{
    NSMutableString *formatString = nil;
    if(bits == 2){
        formatString = [NSMutableString stringWithFormat:@"%.2lf",[number doubleValue]];
    }else if(bits == 4){
        formatString = [NSMutableString stringWithFormat:@"%.4lf",[number doubleValue]];
    }
    return [formatString doubleValue];
}

+ (BOOL)isValidateFormat:(NSString*)format type:(CheckFormatType)type
{
    BOOL result = NO;
    NSString *regex = nil;
    
    switch (type){
        case CheckFormatTypeEmail:{
            regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            result = [test evaluateWithObject:format];
            break;
        }
        case CheckFormatTypePassword:{
            //@"^[a-zA-Z0-9_]+$"
            regex = @".{8,16}";
            NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            result = [test evaluateWithObject:format];
            break;
        }
        case CheckFormatTypeMoney:{
            regex = @"[0-9]+\\.?[0-9]*|\\.[0-9]+";
            NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            result = [test evaluateWithObject:format];
            break;
        }
        case CheckFormatTypePhone:{
            //@"[0-9]{1,13}"
            regex = @"^1[0-9]\\d{9}$";
            NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            result = [test evaluateWithObject:format];
            break;
        }
        case CheckFormatTypeAT:{
            regex = @"(@[\u4e00-\u9fa5a-zA-Z0-9_-]{4,30})";
            NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            result = [test evaluateWithObject:format];
            break;
        }
        case CheckFormatTypeTAG:{
            regex = @"[0-9]{1,13}";
            NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            result = [test evaluateWithObject:format];
            break;
        }
        case CheckFormatTypeOwnEmoji:{
            regex = @"\\[(.*?)\\]";
            NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            result = [test evaluateWithObject:format];
            break;
        }
        case CheckFormatTypeSearchKey:{
            NSCharacterSet *correctSet = [NSCharacterSet characterSetWithCharactersInString:@"<>~~!～@#$%^&*+-={}|:\"<>?[]\\;'/.,œ∑®†¥øπ“‘«åß∂ƒ©˙∆˚¬…æΩ≈ç√∫µ≤≥÷Œ„´‰ˇÁ¨ˆØ∏”’»ÅÍÎÏ˝ÓÔÒÚÆ¸˛Ç◊ı˜Â¯˘¿€£•＜~＞「」（）；：。，？、＂＂！“~·！@#￥%……&*-+=——／"];
            NSRange textRange = [format rangeOfCharacterFromSet:correctSet];
            result = (textRange.location!= NSNotFound)?NO:YES;
            break;
        }
        case CheckFormatTypeURL:{
            NSString *urlRegex =@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
            NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
            result = [urlTest evaluateWithObject:format];
            BOOL bFlag = NO;
            if([format rangeOfString:@"www."].location != NSNotFound){
                NSRange range = [format rangeOfString:@"www."];
                NSRange rangeTmp = NSMakeRange(range.location-1, 1);
                if([[format substringWithRange:rangeTmp] isEqualToString:@"w"]) bFlag = YES;
            }
            result = (result && !bFlag)?YES:NO;
            break;
        }
        case CheckFormatTypeSpecialCharacter:{
            regex = @"^[A-Za-z0-9\u4E00-\u9FA5_-]+$";
            NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
            result = [test evaluateWithObject:format];
            break;
        }
        default:
            break;
    }
    return result;
}

+ (BOOL)checkEmoji:(NSString*)string
{
    if (string.length == 0) return NO;
    
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        }
        else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        }
        else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            }
            else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            }
            else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            }
            else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            }
            else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    
    return returnValue;
}
+ (BOOL)checkUrl:(NSString *)string
{
    NSString *urlRegex =@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    BOOL result = [urlTest evaluateWithObject:string];
    BOOL bFlag = NO;
    if([string rangeOfString:@"www."].location != NSNotFound){
        NSRange range = [string rangeOfString:@"www."];
        NSRange rangeTmp = NSMakeRange(range.location-1, 1);
        if([[string substringWithRange:rangeTmp] isEqualToString:@"w"]) bFlag = YES;
    }
    return (result && !bFlag)?YES:NO;
}

@end
