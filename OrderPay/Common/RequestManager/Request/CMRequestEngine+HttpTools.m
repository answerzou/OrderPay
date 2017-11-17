//
//  CMRequestEngine+HttpTools.m
//  LoanInternalPlus
//
//  Created by leipeng on 2017/8/24.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMRequestEngine+HttpTools.h"
#import "YYModel.h"
#import "CMResponseTip.h"

@implementation CMRequestEngine (HttpTools)
/**
 校验请求
 
 @param params 参数
 @param type 请求类型
 @param flag 请求标识
 @param completion 回调
 @return YES校验失败
 */
- (BOOL)adjustRequestParameters:(NSDictionary *)params type:(JYRequestType)type flag:(JYRequestFlag)flag completion:(void(^)(CMResponseTip *tip,id obj))completion{
    __block CMResponseTip* tip = [[CMResponseTip alloc] init];
    
    
    // adjust network
    if (![AFNetworkReachabilityManager sharedManager].isReachable){
        [tip setWithWithCode:JYRequestErrorHostNotReach error:@"local network error!"];
        [tip processError:^{
            if(completion){
                completion(tip,nil);
            }
        }];
        return YES;
    }
    
    //adjust params
    if (![self adjustDictionaryHavingKeys:params,nil]){
        [tip setWithWithCode:JYRequestErrorLoseParam error:@"param lose error!"];
        [tip processError:^{
            if(completion){
                completion(tip,nil);
            }
        }];
        return YES;
    }
    
    //adjust in queue
    NSString* strFlag = [NSString stringWithFormat:@"%@",@(flag)];
    if ([self adjustQueueItemType:type flag:strFlag]){
        [tip setWithWithCode:JYRequestErrorSameInQueue error:@"same request in queue!"];
        [tip processError:^{
            if(completion){
                completion(tip,nil);
            }
        }];
        return YES;
    }
    return NO;
}
- (void)postWithUrl:(NSString *)url parameters:(NSDictionary *)params type:(JYRequestType)type completion:(void(^)(CMResponseTip *tip,id obj))completion{
    [self postWithUrl:url parameters:params type:type flag:type+2000 completion:completion];
    
}

- (void)postWithUrl:(NSString *)url parameters:(NSDictionary *)params type:(JYRequestType)type flag:(JYRequestFlag)flag completion:(void(^)(CMResponseTip *tip,id obj))completion{
    
    __block CMResponseTip* tip = [[CMResponseTip alloc] init];
    
    //adjust request 校验请求
    if ([self adjustRequestParameters:params type:type flag:flag completion:completion]) {
        return;
    }
    
    //request 请求方法
    NSURLSessionDataTask* request = [self.afRequestManager POST:url  parameters:params progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //转Response模型
        tip = [CMResponseTip yy_modelWithJSON:dic];
        if (tip.success) {//成功回调
            
            //所有请求公用回调
            [tip processError:^{
                //请求回调
                if(completion){
                    completion(tip,dic[KResponseBody]);
                }
            }];
        }else{
            //所有请求公用回调
            [tip processError:^{
                //请求回调
                if(completion){
                    completion(tip,nil);
                }
            }];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败回调
        if (error.code == NSURLErrorCancelled) {//请求取消
            [tip setWithWithCode:JYRequestErrorCancel error:nil];
        }else if(error.code == NSURLErrorTimedOut){//请求超时
            [tip setWithWithCode:JYRequestErrorTimeOut error:nil];
        }else{
            [tip setWithWithCode:JYRequestErrorHostNotReach error:nil];
        }
        [tip processError:^{
            if(completion){
                completion(tip,nil);
            }
        }];
    }];
    //userinfo
    NSString* strFlag = [NSString stringWithFormat:@"%@",@(flag)];
    [self requestSettings:request type:type flag:strFlag tip:tip];
    
}
#pragma mark - 上传方法

- (void)uploadWithUrl:(NSString *)url fileUrlArr:(NSArray *)fileUrlArr parameters:(NSDictionary *)params type:(JYRequestType)type flag:(JYRequestFlag)flag progress:(void (^)(CMResponseTip *))progress completion:(void (^)(CMResponseTip *, id))completion{
    
    __block CMResponseTip* tip = [[CMResponseTip alloc] init];
    // adjust network
    if (![AFNetworkReachabilityManager sharedManager].isReachable){
        [tip setWithWithCode:JYRequestErrorHostNotReach error:@"local network error!"];
        [tip processError:^{
            if(completion){
                completion(tip,nil);
            }
        }];
        return;
    }
    //adjust in queue
    NSString* strFlag = [NSString stringWithFormat:@"%@",@(flag)];
    if ([self adjustQueueItemType:type flag:strFlag]){
        [tip setWithWithCode:JYRequestErrorSameInQueue error:@"same request in queue!"];
        [tip processError:^{
            if(completion){
                completion(tip,nil);
            }
        }];
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    //request 请求方法
    NSURLSessionDataTask* request = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i<fileUrlArr.count; i++) {
            
            NSDictionary *photoDic = fileUrlArr[i];
            
            NSString *filePath = photoDic[@"imagePath"];
            
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
            
            NSData *imageData = UIImageJPEGRepresentation(image, 1);
            
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:imageData
                                        name:@"name"
                                    fileName:photoDic[@"imageName"]
                                    mimeType:@"image/jpeg"];
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
//            tip.uploadProgress = uploadProgress.fractionCompleted;
            progress(tip);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic;
        if ([[responseObject class] isSubclassOfClass:[NSDictionary class]]) {
            dic = responseObject;
        }else{
            dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        }
        //转Response模型
        tip = [CMResponseTip yy_modelWithJSON:dic];
        if (tip.success) {//成功回调
            //所有请求公用回调
            [tip processError:^{
                //请求回调
                if(completion){
                    completion(tip,dic[KResponseBody]);
                }
            }];
        }else{
            //所有请求公用回调
            [tip processError:^{
                //请求回调
                if(completion){
                    completion(tip,nil);
                }
            }];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败回调
        if (error.code == NSURLErrorCancelled) {//请求取消
            [tip setWithWithCode:JYRequestErrorCancel error:nil];
        }else if(error.code == NSURLErrorTimedOut){//请求超时
            [tip setWithWithCode:JYRequestErrorTimeOut error:nil];
        }else{
            [tip setWithWithCode:JYRequestErrorHostNotReach error:nil];
        }
        [tip processError:^{
            if(completion){
                completion(tip,nil);
            }
        }];
    }];
    //userinfo
    [self requestSettings:request type:type flag:strFlag tip:tip];
}
- (void)uploadWithUrl:(NSString *)url fileUrl:(NSString *)fileUrl parameters:(NSDictionary *)params type:(JYRequestType)type progress:(void(^)(CMResponseTip *tip))progress completion:(void(^)(CMResponseTip *tip,id obj))completion{
    [self uploadWithUrl:url fileUrlArr:@[fileUrl] parameters:params type:type flag:type+2000 progress:progress completion:completion];
}

- (void)cancelRequestType:(JYRequestType)type
{
    //取消请求，flag默认为type+2000
    [self cancelRequestWithType:type
                           flag:[NSString stringWithFormat:@"%@",@(type+2000)]];
}
- (void)cancelRequestType:(JYRequestType)type flag:(JYRequestFlag)flage{
    //取消请求
    [self cancelRequestWithType:type
                           flag:[NSString stringWithFormat:@"%@",@(flage)]];
}
@end
