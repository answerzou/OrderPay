//
//  CMFile.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface CMFile : NSObject

/**
 *reference:adjust file exist
 *parameters:strPath(file path)
 *return:yes or no
 */
+ (BOOL)adjustFileAtPath:(NSString*)strPath;

/**
 *reference:delete file
 *parameters:strPath(file path)
 *return:yes or no
 */
+ (BOOL)deleteFileAtPath:(NSString*)strPath;

/**
 *reference:create directory or file
 *parameters:strPath(file path)
 *return:yes or no
 */
+ (BOOL)createDirectoryAtPath:(NSString*)strPath;

/**
 *reference:copy src  to des
 *parameters:srcPath(source file path),desPath(des filepath)
 *return:yes or no
 */
+ (BOOL)copyItemAtPath:(NSString*)srcPath toPath:(NSString*)desPath;

/**
 *reference:get temp path
 *parameters:null
 *return:temp path
 */
+ (NSString*)tempPath;

/**
 *reference:get document path
 *parameters:null
 *return:temp path
 */
+ (NSString*)documentPath;

/**
 *reference:get random file path
 *parameters:suffix: jpg,jpeg,mp4...
 *return:file path
 */
+ (NSString*)randomFileNameWithSuffix:(NSString*)suffix;

/**
 *reference:get mime type
 *parameters:fileName ,have suffix
 *return:mime type
 */
+ (NSString*)mimeType:(NSString*)fileName;

@end

@interface CMFile (audio)

#define CM_AUDIO_PLAY_DIR          @"/AudioPlay/"
#define CM_AUDIO_RECORD_DIR        @"/AudioRecord/"

+ (NSString*)homeAudioDirectory4Play;
+ (NSString*)randomAudioFilePath4Record;

@end
