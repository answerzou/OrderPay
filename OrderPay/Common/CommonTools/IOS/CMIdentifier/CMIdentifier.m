//
//  CMIdentifier.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMIdentifier.h"
#import "CMSecurity.h"
#import "SSKeychain.h"
#import "UIDevice+IdentifierAddition.h"
#include <sys/sysctl.h>

@implementation CMIdentifier
#pragma mark --
#pragma mark Identifier

+ (NSString*)platform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

/* hash string for mac address */
+ (NSString*) appMacIdentifier
{
    return [[UIDevice currentDevice] uniqueDeviceIdentifier];
}

/* hash string for mac address and bundle id*/
+ (NSString*) appGlobalIdentifier
{
    return [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
}

/*store identifier*/
+ (BOOL)storeDefaultIdentifier:(NSString*)iden
{
    if (!iden) return NO;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* encrptiden = [iden AESEncryptWithKey:KAESKey];
    [userDefaults setObject:encrptiden forKey:CM_IDENTIFIER_ID];
    [userDefaults synchronize];
    return YES;
}

/*get identifier*/
+ (NSString*)loadDefaultIdentifier
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* strid = (NSString*)[userDefaults valueForKey:CM_IDENTIFIER_ID];
    strid = [strid AESDecryptWithKey:KAESKey];
    return strid;
}

/*store identifier to keychain*/
+ (BOOL)storeKeyChainIdentifier:(NSString*)identifier
{
    NSString* strTemp = (identifier.length > 0)?identifier:@"";
    [SSKeychain setPassword:strTemp forService:CM_IDENTIFIER_COMPANY account:CM_IDENTIFIER_ID];
    return YES;
}

/*get identifier frome keychain*/
+ (NSString*)loadKeyChainIdentifier
{
    NSString *identifier = [SSKeychain passwordForService:CM_IDENTIFIER_COMPANY account:CM_IDENTIFIER_ID];
    return identifier;
}

/*get a uuid*/
+ (NSString *)generateUUIDString
{
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    CFStringRef strRef = CFUUIDCreateString(kCFAllocatorDefault, uuid);
    NSString *uuidString = [NSString stringWithFormat:@"%@",(__bridge NSString*)strRef];
    
    CFRelease(strRef);
    CFRelease(uuid);
    return uuidString;
}

@end
