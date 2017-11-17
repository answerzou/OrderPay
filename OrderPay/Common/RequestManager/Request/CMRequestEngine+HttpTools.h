//
//  CMRequestEngine+HttpTools.h
//  LoanInternalPlus
//
//  Created by leipeng on 2017/8/24.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMRequestEngine.h"
#import "CMResponseTip.h"
@interface CMRequestEngine (HttpTools)

/**
 post请求

 @param url 请求地址
 @param params 参数字典
 @param type 请求类型
 @param completion 请求回调
 */
- (void)postWithUrl:(NSString *)url parameters:(NSDictionary *)params type:(JYRequestType)type completion:(void(^)(CMResponseTip *tip,id obj))completion;

/**
 post请求 带flag请求标识

 @param url 请求地址
 @param params 参数字典
 @param type 请求类型
 @param flag flag
 @param completion 请求回调
 */
- (void)postWithUrl:(NSString *)url parameters:(NSDictionary *)params type:(JYRequestType)type flag:(JYRequestFlag)flag completion:(void(^)(CMResponseTip *tip,id obj))completion;

/**
 上传

 @param url 地址
 @param fileUrlArr 文件地址数组
 @param params 字典参数
 @param type 请求类型
 @param flag flag
 @param progress 进度回调
 @param completion 请求回调
 */
- (void)uploadWithUrl:(NSString *)url fileUrlArr:(NSArray *)fileUrlArr parameters:(NSDictionary *)params type:(JYRequestType)type flag:(JYRequestFlag)flag progress:(void(^)(CMResponseTip *tip))progress completion:(void(^)(CMResponseTip *tip,id obj))completion;
/**
 上传
 
 @param url 地址
 @param fileUrl 文件地址
 @param params 字典参数
 @param type 请求类型
 @param progress 进度回调
 @param completion 请求回调
 */
- (void)uploadWithUrl:(NSString *)url fileUrl:(NSString *)fileUrl parameters:(NSDictionary *)params type:(JYRequestType)type progress:(void(^)(CMResponseTip *tip))progress completion:(void(^)(CMResponseTip *tip,id obj))completion;
/**
 取消请求

 @param type 取消的请求类型
 */
- (void)cancelRequestType:(JYRequestType)type;

/**
 取消请求

 @param type 取消的请求类型
 @param flag 取消的请求flag
 */
- (void)cancelRequestType:(JYRequestType)type flag:(JYRequestFlag)flag;
@end
