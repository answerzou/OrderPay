//
//  CMSecurity.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const KAESKey = @"d*7jdkl@9&%";
static NSString *const KDESKey = @"6F3FAEBE5B960978A092AEBE";
static NSString *const KDESVec = @"01234567";


@interface NSString (Base64Addition)
+(NSString *)stringFromBase64String:(NSString *)base64String;
-(NSString *)base64String;
@end

@interface NSString (MD5)
- (NSString *)MD5Digest;
@end

@interface NSString (AES)
- (NSString *)AESEncryptWithKey:(NSString *)key;
- (NSString *)AESDecryptWithKey:(NSString *)key;
@end

@interface NSString (DES)
+ (NSString *)DESEncryptWithKey:(NSString *)encryptStr;
+ (NSString *)DESDecryptWithKey:(NSString *)decryptStr;
@end

@interface NSData (Base64Addition)
+(NSData *)dataWithBase64String:(NSString *)base64String;
-(NSString *)base64String;
@end

@interface NSData (MD5)
- (NSString *)md5;
@end

@interface NSData (AES)
- (NSData *)AESEncryptWithKey:(NSString *)key;
- (NSData *)AESDecryptWithKey:(NSString *)key;
@end
@interface CMSecurity : NSObject
+(NSData *)dataFromBase64String:(NSString *)base64String;
+(NSString *)base64StringFromData:(NSData *)data;
@end

