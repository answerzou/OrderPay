//
//  CMRequestEngine.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMRequestEngine.h"
#import "BlocksKit.h"
#import "CMResponseTip.h"

static CMRequestEngine *__shareNetManager = nil;

@interface CMRequestEngine()
@property(nonatomic, strong)AFHTTPSessionManager*  afRequestManager;
@property(nonatomic, copy) NSString* versionName;
@property(nonatomic, copy) NSString* terminal;
@property(nonatomic, copy) NSString* language;

@end
@implementation CMRequestEngine
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shareNetManager = [[self alloc] init];
    });
    return __shareNetManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shareNetManager = [super allocWithZone:zone];
    });
    return __shareNetManager;
}

- (id)copyWithZone:(NSZone *)zone
{
    return __shareNetManager;
}

- (instancetype)init
{
    if (self = [super init]){
        _afRequestManager = [AFHTTPSessionManager manager];
        
        //net indicatior
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        _afRequestManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _afRequestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _afRequestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
        //超时
        _afRequestManager.requestSerializer.timeoutInterval = 90;
        
        //terminal
        _terminal = @"ios";
        
        //version name
        _versionName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        
        //language
        NSArray *languages = [NSLocale preferredLanguages];
        _language = [languages objectAtIndex:0];
    }
    return self;
}

- (BOOL)adjustDictionaryHavingKeys:(NSDictionary*)dic,...
{
    if (!dic) return NO;
    
    NSMutableArray* argsArray = [NSMutableArray array];
    id arg = nil;
    va_list argList;
    if(dic){
        va_start(argList,dic);
        while ((arg = va_arg(argList, id))){
            [argsArray addObject:arg];
        }
        va_end(argList);
    }
    
    NSDictionary* dictionary = dic;
    id loseKey = [argsArray bk_match:^(id obj){
        if (![dictionary objectForKey:obj]) {
            return YES;
        }
        return NO;
    }];
    
    if (loseKey){
        return NO;
    }
    return YES;
}

- (NSString*)fullUrlWithSubString:(NSString*)strSubType
{
    NSString* strFormat = [NSString stringWithFormat:@"%@%@",WD_DOMAIN,strSubType];
    return [strFormat stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)fullUrlWithMainUrl:(NSString *)mainUrl andParams:(NSDictionary *)parameters
{
    if(!mainUrl || parameters.count == 0)  return nil;
    
    NSMutableArray *parametersArray = [NSMutableArray array];
    [parameters bk_each:^(id key, id obj){
        if ([obj isKindOfClass:[NSString class]]) {
            NSString* escaped_value =
            (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                  NULL, /* allocator */
                                                                                  (CFStringRef)obj,
                                                                                  NULL, /* charactersToLeaveUnescaped */
                                                                                  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                  kCFStringEncodingUTF8);
            [parametersArray addObject:[NSString stringWithFormat:@"%@=%@",key,escaped_value]];
        }
        else{
            [parametersArray addObject:[NSString stringWithFormat:@"%@=%@",key,obj]];
        }
    }];
    
    NSString * paramStr = [parametersArray componentsJoinedByString:@"&"];
    return [NSString stringWithFormat:@"%@?%@",mainUrl,paramStr];
}

- (BOOL)adjustQueueItemType:(NSInteger)type flag:(NSString*)flag
{
    id request = [self.afRequestManager.tasks bk_match:^(NSURLSessionDataTask* request){
        CMResponseTip* tip = [request.userinfo objectForKey:KResponseTip];
        if (tip&&(tip.type == type)&&[tip.flag isEqualToString:flag]){
            return YES;
        }
        return NO;
    }];
    
    if (request){
        return YES;
    }
    return NO;
}

- (void)cancelRequestWithType:(NSInteger)type
{
    [self.afRequestManager.tasks bk_match:^(NSURLSessionDataTask* request){
        CMResponseTip* tip = [request.userinfo objectForKey:KResponseTip];
        if (tip&&(tip.type == type)){
            [request cancel];
            return YES;
        }
        return NO;
    }];

}
- (void)cancelRequestWithType:(NSInteger)type flag:(NSString*)flag
{
    if (flag.length == 0) return;
    [self.afRequestManager.tasks bk_match:^(NSURLSessionDataTask* request){
        CMResponseTip* tip = [request.userinfo objectForKey:KResponseTip];
        if (tip&&(tip.type == type)&&[tip.flag isEqualToString:flag]){
            [request cancel];
            return YES;
        }
        return NO;
    }];
}

- (void)requestSettings:(NSURLSessionDataTask*)request type:(NSInteger)type flag:(NSString*)flag tip:(CMResponseTip *)tip
{
    if (!tip) return;
    
    NSMutableDictionary* userinfo = [NSMutableDictionary dictionary];
    tip.type = type;
    tip.flag = flag;
    
    [userinfo setObject:tip forKey:KResponseTip];
    request.userinfo = userinfo;
}

- (NSMutableDictionary*)addBaseParams:(NSDictionary*)params
{
       NSMutableDictionary* dics = nil;
    if (params){
        dics = [NSMutableDictionary dictionaryWithDictionary:params];
    }
    else{
        dics = [NSMutableDictionary dictionary];
    }
//    //version name
//    [dics setObject:self.versionName forKey:KVersionName];
//    //android or ios
//    [dics setObject:self.terminal forKey:KTerminal];

    return dics;
}

- (NSString *)getParamValueFromUrl:(NSString*)url paramName:(NSString *)paramName
{
    if (![paramName hasSuffix:@"="]){
        paramName = [NSString stringWithFormat:@"%@=", paramName];
    }
    
    NSString * str = nil;
    NSString *tmpStr = nil;
    NSRange start = [url rangeOfString:paramName];
    if (start.location != NSNotFound){
        unichar c = '?';
        if (start.location != 0){
            c = [url characterAtIndex:start.location - 1];
        }
        if (c == '?' || c == '&' || c == '#'){
            NSRange end = [[url substringFromIndex:start.location+start.length] rangeOfString:@"&"];
            NSUInteger offset = start.location+start.length;
            str = end.location == NSNotFound ?
            [url substringFromIndex:offset] :
            [url substringWithRange:NSMakeRange(offset, end.location)];
            tmpStr = [NSString stringWithString:str];
            str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }
    
    if(str){
        return str;
    }
    else{
        return tmpStr;
    }
}

- (void)cancelAllRequests
{
    [_afRequestManager.operationQueue cancelAllOperations];
}

@end
