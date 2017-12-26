//
//  ApiMacro.swift
//  NewEasyRepayment
//
//  Created by mcintosh on 2017/9/4.
//  Copyright © 2017年 jieyuechina. All rights reserved.
//

import SnapKit

/// 测试环境地址
//let APP_SERVER_API = "http://192.168.32.174:8080"

/// 正式环境地址
let APP_SERVER_API = "http://app.buyijinfu.com/xdyAppServer"


//--------用户登录及相关接口--------//
///登录
let API_POST_LOGIN         = APP_SERVER_API+"/xdyWeiXinServer/api/APPBizRest/appLogin/v1/"

///注册
let API_POST_REGISTER         = APP_SERVER_API+"/xdyWeiXinServer/api/APPBizRest/appRegister/v1/"
///验证码
let API_POST_VERIFICATION     = APP_SERVER_API+"/xdyWeiXinServer/api/APPBizRest/sendSMCode/v1/"

//---------保存用户通讯录----------//
let API_POST_SAVEADDRESSBOOKS     = APP_SERVER_API+"/xdyWeiXinServer/api/APPBizRest/saveAddressBooks/v1/"

//---------保存基本信息----------//
let API_POST_APPAUTH     = APP_SERVER_API+"/xdyWeiXinServer/api/APPBizRest/appAuth/v1/"

///我的订单
let API_POST_MYGETLIST     = APP_SERVER_API+"/xdyWeiXinServer/api/APPBizRest/queryMyGetList/v1/"

///版本控制
let API_POST_UPAPPVERSION     = APP_SERVER_API+"/xdyWeiXinServer/api/APPBizRest/goUpAppVersion/v1/"









