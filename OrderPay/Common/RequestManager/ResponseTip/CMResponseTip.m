//
//  CMResponseTip.m
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "CMResponseTip.h"

@implementation CMResponseTip

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"JYCID":@"CID",@"JYPTID":@"PID"};
}

- (BOOL)success{
    return [_retCode isEqualToString:@"200"];
}

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"JYCID":@"CID",@"JYPTID":@"PID"};
}
- (NSString *)errorDesc{
    if (!_errorDesc||_errorDesc.length == 0) {
        if (self.errorCode == JYRequestErrorTimeOut) {//超时
            _errorDesc = @"网络请求失败，请稍后再试";
        }else if (self.errorCode == JYRequestErrorHostNotReach){//连接失败
            _errorDesc = @"网络请求失败，请稍后再试";
        }
    }
    return _errorDesc;
}
- (void)setWithWithCode:(NSInteger)cd error:(NSString*)er
{
    self.errorCode = cd;
    self.errorDesc = er;
}

- (void)processError:(void (^)(void))callback
{
    switch (self.requestCode) {
        case JYRequestTypeLogin:
        {
            if (callback) {
                callback();
            }
        }
            break;
            
        default:{
            //            self.error_unprocessed = YES;
            //            if (self.error.length > 0){
            //
            //            }
            if (callback) {
                callback();
            }
            break;
        };
    }
}

@end
