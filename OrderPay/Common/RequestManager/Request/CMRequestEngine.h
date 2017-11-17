//
//  CMRequestEngine.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMResponseTip.h"
#import "CMResponseTip.h"
//#import "AFNetworking.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
//#import "AFNetworkActivityIndicatorManager.h"
#import "NSURLSessionTask+UserInfo.h"

#define WD_DOMAIN_DEVELOPER
//#define WD_DOMAIN_TEST
//#define WD_DOMAIN_PRERELEASE
//#define WD_DOMAIN_RELEASE

#if defined(WD_DOMAIN_DEVELOPER)
#define WD_DOMAIN @"http://XXXX.com"
#elif defined(WD_DOMAIN_TEST)
#define WD_DOMAIN   @"http://XXXX.com"
#elif defined(WD_DOMAIN_PRERELEASE)
#define WD_DOMAIN    @"http://XXXX.com"
#elif defined(WD_DOMAIN_RELEASE)
#define WD_DOMAIN    @"http://XXXX.com"
#endif

/******************************************************************/

#define CR_BLOCK(tip,data)  {[tip processError:^{if(block){block(tip,data);}}];}
typedef void(^CompleteBlock)(CMResponseTip* tip,id result);
typedef void(^SingleBlock)(CMResponseTip* tip);

#define KRequestTimeOut     90
#define KRetCode @"retCode"
#define KErrorDesc @"errorDesc"
#define KBody    @"responseBody"

@interface CMRequestEngine : NSObject
@property(nonatomic,strong,readonly) AFHTTPSessionManager*  afRequestManager;
@property(nonatomic,copy,readonly) NSString* versionName;
@property(nonatomic,copy,readonly) NSString* terminal;
@property(nonatomic,copy,readonly) NSString* language;

+ (instancetype)sharedInstance;

- (void)cancelAllRequests;

- (BOOL)adjustDictionaryHavingKeys:(NSDictionary*)dic,...;
- (BOOL)adjustQueueItemType:(NSInteger)type flag:(NSString*)flag;
- (NSString*)fullUrlWithSubString:(NSString*)strSubType;
- (NSString *)fullUrlWithMainUrl:(NSString *)mainUrl andParams:(NSDictionary *)parameters;
- (void)cancelRequestWithType:(NSInteger)type;
- (void)cancelRequestWithType:(NSInteger)type flag:(NSString*)flag;
- (void)requestSettings:(NSURLSessionDataTask*)request type:(NSInteger)type flag:(NSString*)flag tip:(CMResponseTip*)tip;
- (NSMutableDictionary*)addBaseParams:(NSDictionary*)params;
- (NSString *)getParamValueFromUrl:(NSString*)url paramName:(NSString *)paramName;
@end
