//
//  ApiMacro.swift
//  NewEasyRepayment
//
//  Created by mcintosh on 2017/9/4.
//  Copyright © 2017年 jieyuechina. All rights reserved.
//


//---------
/**
 注意:
 1、登录界面 pid和激活界面 传的是空值    --ok
 2、发布时清空测试数据                 --ok
 3、核对发布地址                      --ok
 4、核对第三方SDK地址Key等信息         --ok
 5、测试打包IPA                      --ok
 **/


import SnapKit

//生产环境
//let APP_SERVER_API = "https://easypay.jieyuechina.com/repayEasyAppServer"


/// 测试环境地址
let APP_SERVER_API = "http://192.168.32.174:8080"

//--------用户登录及相关接口--------//
//登录
//注册
let API_POST_REGISTER         = APP_SERVER_API+"/xdyWeiXinServer/api/APPBizRest/appRegister/v1/"
//验证码
let API_POST_VERIFICATION     = APP_SERVER_API+"/xdyWeiXinServer/api/APPBizRest/sendSMCode/v1/"









