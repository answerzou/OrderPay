//
//  CMDevice.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, Hardware) {
    NOT_AVAILABLE,
    
    IPHONE_2G,
    IPHONE_3G,
    IPHONE_3GS,
    IPHONE_4,
    IPHONE_4_CDMA,
    IPHONE_4S,
    IPHONE_5,
    IPHONE_5_CDMA_GSM,
    IPHONE_5C,
    IPHONE_5C_CDMA_GSM,
    IPHONE_5S,
    IPHONE_5S_CDMA_GSM,
    IPHONE_6_PLUS,
    IPHONE_6,
    
    IPOD_TOUCH_1G,
    IPOD_TOUCH_2G,
    IPOD_TOUCH_3G,
    IPOD_TOUCH_4G,
    IPOD_TOUCH_5G,
    
    IPAD,
    IPAD_2,
    IPAD_2_WIFI,
    IPAD_2_CDMA,
    IPAD_3,
    IPAD_3G,
    IPAD_3_WIFI,
    IPAD_3_WIFI_CDMA,
    IPAD_4,
    IPAD_4_WIFI,
    IPAD_4_GSM_CDMA,
    
    IPAD_MINI,
    IPAD_MINI_WIFI,
    IPAD_MINI_WIFI_CDMA,
    IPAD_MINI_RETINA_WIFI,
    IPAD_MINI_RETINA_WIFI_CDMA,
    IPAD_MINI_3_WIFI,
    IPAD_MINI_3_WIFI_CELLULAR,
    IPAD_MINI_RETINA_WIFI_CELLULAR_CN,
    
    IPAD_AIR_WIFI,
    IPAD_AIR_WIFI_GSM,
    IPAD_AIR_WIFI_CDMA,
    IPAD_AIR_2_WIFI,
    IPAD_AIR_2_WIFI_CELLULAR,
    
    SIMULATOR
};

#ifndef PHONE_DEVICE_H_4
#define PHONE_DEVICE_H_4 ([FTDevice deviceSystemHeight] == 480)
#endif

#ifndef PHONE_DEVICE_H_5
#define PHONE_DEVICE_H_5 ([FTDevice deviceSystemHeight] == 568)
#endif

#ifndef PHONE_DEVICE_H_6
#define PHONE_DEVICE_H_6 ([FTDevice deviceSystemHeight] == 667)
#endif

#ifndef PHONE_DEVICE_H_6P
#define PHONE_DEVICE_H_6P ([FTDevice deviceSystemHeight] == 736)
#endif

#define DEVICE_W    [FTDevice deviceSystemWidth]
#define DEVICE_H    [FTDevice deviceSystemHeight]
@interface CMDevice : NSObject
/**
 *reference:device model iphone or ipad
 *parameters:null
 *return:0 or 1
 */
+ (NSNumber*)deviceModel;

/**
 *reference:device model iphone or ipad
 *parameters:null
 *return:model string
 */
+ (NSString*)modelName;

/**
 *reference:device model iphone or ipad
 *parameters:null
 *return:platform string
 */
+ (NSString*)platform;

/**
 *reference:device system and version
 *parameters:null
 *return:systemVersion
 */
+ (NSInteger)deviceSystemVersion;

/**
 *reference:device system name
 *parameters:null
 *return:iphone or ipad string
 */
+ (NSString*)deviceSystemName;

/**
 *reference:the app version permit by version
 *parameters:null
 *return:yes or no
 */
+ (BOOL)versionPermit;
/**
 *reference:the app version permit by version
 *parameters:ver(first version code),sec(second version code)
 *return:yes or no
 */
+ (BOOL)versionPermit:(NSInteger)ver second:(NSInteger)sec;

/**
 *reference:current screen scale
 *parameters:null
 *return:scale string
 */
+ (NSString*)screenScale;

/**
 *reference:device height
 *parameters:null
 *return:height
 */
+ (NSInteger)deviceSystemHeight;

/**
 *reference:device width
 *parameters:null
 *return:width
 */
+ (NSInteger)deviceSystemWidth;

/**
 *reference:current screen bounds
 *parameters:null
 *return:bounds string
 */
+ (NSString*)screenBounds;


/** This method retruns the hardware type */
+ (NSString*)hardwareString;

/** This method returns the Hardware enum depending upon harware string */
+ (Hardware)hardware;

/** This method returns the readable description of hardware string */
+ (NSString*)hardwareDescription;

/** This method returns the readable simple description of hardware string */
+ (NSString*)hardwareSimpleDescription;

/**
 This method returns the hardware number not actual but logically.
 e.g. if the hardware string is 5,1 then hardware number would be 5.1
 */
+ (float)hardwareNumber:(Hardware)hardware;

/** This method returns the resolution for still image that can be received
 from back camera of the current device. Resolution returned for image oriented landscape right. **/
+ (CGSize)backCameraStillImageResolutionInPixels;


@end
