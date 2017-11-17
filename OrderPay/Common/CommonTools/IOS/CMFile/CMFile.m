//
//  CMFile.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMFile.h"

@implementation CMFile
+ (BOOL)adjustFileAtPath:(NSString*)strPath
{
    if (!strPath) return NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:strPath];
}

+ (BOOL)deleteFileAtPath:(NSString*)strPath
{
    if (!strPath) return NO;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:strPath]) return YES;
    
    NSError *error = nil;
    BOOL bRet = [fileManager removeItemAtPath:strPath error:&error];
    if (error){
    }
    return bRet;
}

+ (BOOL)createDirectoryAtPath:(NSString*)strPath
{
    if (!strPath) return NO;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL bRet = [fileManager createDirectoryAtPath:strPath withIntermediateDirectories:YES attributes:nil error:&error];
    
    if (error){
    }
    return bRet;
}

+ (BOOL)copyItemAtPath:(NSString*)srcPath toPath:(NSString*)desPath
{
    if (!srcPath || !desPath) return NO;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:srcPath]) return NO;
    
    NSError *error = nil;
    BOOL bRet = [fileManager copyItemAtPath:srcPath toPath:desPath error:&error];
    
    if (error){
    }
    return bRet;
}

+ (NSString*)tempPath
{
    return NSTemporaryDirectory();
}

+ (NSString*)documentPath
{
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    return documentsDirectory;
}

+ (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to
{
    return (NSInteger)(from+(arc4random()%(to-from +1)));
}

+ (NSString*)randomFileNameWithSuffix:(NSString*)suffix
{
    NSString* strTemp = (suffix && suffix.length > 0)?suffix:@"";
    NSTimeInterval var = [[NSDate date] timeIntervalSince1970];
    NSInteger rand = [self getRandomNumber:100000 to:999999];
    return [NSString stringWithFormat:@"%.0f%ld.%@",var*1000,(long)rand,strTemp];
}

+ (NSString *)mimeType:(NSString*)fileName
{
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[fileName pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    NSString *mimeType = [(__bridge NSString *)MIMEType copy];
    CFRelease(UTI);
    CFRelease(MIMEType);
    
    return mimeType;
}
@end


@implementation CMFile (audio)
+ (NSString*)homeAudioDirectory4Play
{
    NSString *path = [NSString stringWithFormat:@"%@%@",[CMFile documentPath],CM_AUDIO_PLAY_DIR];
    if (![self adjustFileAtPath:path]){
        [self createDirectoryAtPath:path];
    }
    return path;
}

+ (NSString*)randomAudioFilePath4Record
{
    NSString *path = [NSString stringWithFormat:@"%@%@",[CMFile documentPath],CM_AUDIO_RECORD_DIR];
    NSString* name = [self randomFileNameWithSuffix:@"mp4"];
    if (![self adjustFileAtPath:path]){
        [self createDirectoryAtPath:path];
    }
    return [NSString stringWithFormat:@"%@%@",path,name];
}

@end

