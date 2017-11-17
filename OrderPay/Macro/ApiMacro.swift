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

///UAT
let APP_SERVER_API = "http://115.182.212.71:28081/fintech-appbiz"

/// 测试环境地址
//let APP_SERVER_API = "http://172.18.100.39:8081/fintech-appbiz"

/// 王雪亮 http://192.168.64.253:8080 王小亮 192.168.67.109
//let APP_SERVER_API = "http://192.168.64.253:8080/fintech-appbiz"
//let APP_SERVER_API = "http://192.168.64.253:8080/fintech-appbiz"
/// 刘逸飞
//let APP_SERVER_API = ""
//let APP_SERVER_API = "http://192.168.67.109:8080/fintech-appbiz"
///刘宁h5
//let APP_SERVER_H5 = "http://192.168.64.105:8080/fintech-appbiz"
//debug
let DEBUG_JYAPP = false

//--------用户登录及相关接口--------//
//登录
let API_POST_LOGIN            = APP_SERVER_API+"/api/APPBizRest/appLogin/v1/"
//注册
let API_POST_REGISTER         = APP_SERVER_API+"/api/APPBizRest/appRegister/v1/"
//验证码
let API_POST_VERIFICATION     = APP_SERVER_API+"/api/APPBizRest/appSMCode/v1/"
//验证码校验
let API_POST_VERIFICODE       = APP_SERVER_API+"/api/APPBizRest/checkSMCode/v1/"
//重置密码
let API_POST_RESETPWD         = APP_SERVER_API+"/api/APPBizRest/appPwdReset/v1/"
//版本校验升级
let API_POST_UPAPPVERSION     = APP_SERVER_API+"/api/APPBizRest/goUpAPPVersion/v1/"
//邀请码验证
let API_POST_APPINVITATIONCODE = APP_SERVER_API+"/api/APPBizRest/appInvitationCode/v1/"

/// 图片影像上传接口
/// 压缩包内的图片命名格式：附件类型+_+两位数字编号+后缀
///（如身份证正面：C1_01.jpg、身份证反面：C2_01.jpg 活体：C3_01.jpg）
let API_POST_UPLOADFILEZIP           = APP_SERVER_API+"/api/APPBizRest/uploadFileZip/v1/"
/// 身份证OCR识别（正反面）
let API_POST_QUERYTWOSIDECARDINFO    = APP_SERVER_API+"/api/APPBizRest/queryTwoSideCardInfo/v1/"
/// 身份证OCR识别（单面）
let API_POST_QUERYONESIDECARDINFO    = APP_SERVER_API+"/api/APPBizRest/queryOneSideCardInfo/v1/"
/// 图像人脸识别接口
let API_POST_DETECTFACEINFO          = APP_SERVER_API+"/api/APPBizRest/detectFaceInfo/v1/"
/// 有源对比照片对比接口
let API_POST_CONTRASTSOURCEINFO      = APP_SERVER_API+"/api/APPBizRest/contrastSourceInfo/v1/"
/// 实名认证
let API_POST_APPREGISTER             = APP_SERVER_API+"/api/APPBizRest/appRealNameAuth/v1/"

///----用户信息相关接口设计---
/// 保存手机相关信息
let API_POST_SAVEMOBILEINFOMATION    = APP_SERVER_API+"/api/APPBizRest/saveMobileInformation/v1/"
/// 保存地理位置相关信息
let API_POST_SAVEMOBILEADDRESS       = APP_SERVER_API+"/api/APPBizRest/saveMobileAddress/v1/"
/// 保存用户通讯录
let API_POST_SAVEADDRESSBOOKS        = APP_SERVER_API+"/api/APPBizRest/saveAddressBooks/v1/"


//--------充值相关接口--------//
///	非存管银卡和该渠道是否快捷支付（非存管）
let API_POST_APPNONDEPOSITORYBANKQUICKQUERY         = APP_SERVER_API+"/api/APPBizRest/appNonDepositoryBankQuickQuery/v1/"

///	快捷支付银行卡预绑定（非存管）
let API_POST_APPNONDEPOSITORYBANKPREBINDING         = APP_SERVER_API+"/api/APPBizRest/appNonDepositoryBankPreBinding/v1/"

///	快捷支付银行卡确认绑定（非存管）
let API_POST_APPNONDEPOSITORYBANKCONFIRMBINDING     = APP_SERVER_API+"/api/APPBizRest/appNonDepositoryBankConfirmBinding/v1/"

///	快捷支付预充值（非存管）
let API_POST_APPNONDEPOSITORYBANKPRERECHARGE        = APP_SERVER_API+"/api/APPBizRest/appNonDepositoryBankPreRecharge/v1/"

///	快捷支付确认充值（变更）（非存管）
let API_POST_APPNONDEPOSITORYBANKCONFIRMRECHARGE    = APP_SERVER_API+"/api/APPBizRest/appNonDepositoryBankConfirmRecharge/v1/"

///	充值接口（存管）
let API_POST_APPRECHARGE                            = APP_SERVER_API+"/deposit/appRecharge"

///	非存管查询绑定银行卡接口
let API_POST_DEPOSITORYBANKQUERY                    = APP_SERVER_API+"/api/APPBizRest/appNonDepositoryBankQuery/v1/"

/// 渠道限额查询
let API_POST_CASHRESTRICTION                        = APP_SERVER_API+"/api/APPBizRest/cashRestriction/v1/"


//--------我的银行卡相关接口--------//
/// 存管：查询绑定银行卡接口
let API_POST_APPBANKQUERY                   = APP_SERVER_API + "/api/APPBizRest/appBankQuery/v1/"
/// 非存管：查询绑定银行卡接口
let API_POST_APPNONDEPOSITORYBANKQUERY      = APP_SERVER_API + "/api/APPBizRest/appNonDepositoryBankQuery/v1/"
/// 存管：解绑银行卡接口
let API_POST_APPBANKUNLOCK                  = APP_SERVER_API + "/api/APPBizRest/appBankUnlock/v1/"
/// 非存管：解绑银行卡接口
let API_POST_APPNONDEPOSITORYBANKUNLOCK     = APP_SERVER_API + "/api/APPBizRest/appNonDepositoryBankUnlock/v1/"
/// 存管：绑定银行卡接口
let API_POST_APPBANKBINDING                 = APP_SERVER_API + "/deposit/appBankBinding"
/// 非存管：绑定银行卡接口
let API_POST_APPNONDEPOSITORYBANKBINDING    = APP_SERVER_API + "/api/APPBizRest/appNonDepositoryBankBinding/v1/"
/// 银行名称返显
let API_POST_QUERYBANKBYBANKCARDNO          = APP_SERVER_API + "/api/APPBizRest/queryBankByBankCardNo/v1/"
/// 查询全部银行名称
let API_POST_QUERYBANKBYBANKALL             = APP_SERVER_API + "/api/APPBizRest/queryBankByBankALL/v1/"


//--------我的交易记录相关接口--------//
/// 存管：充值记录查询接口
let API_POST_APPRECHARGEQUERY               = APP_SERVER_API + "/api/APPBizRest/appRechargeQuery/v1/"
/// 非存管：充值记录查询接口
let API_POST_APPNONDEPOSITORYRECHARGEQUERY  = APP_SERVER_API + "/api/APPBizRest/appNonDepositoryRechargeQuery/v1/"
/// 存管：提现记录查询接口
let API_POST_APPCASHRECORDQUERY             = APP_SERVER_API + "/api/APPBizRest/appCashRecordQuery/v1/"

//--------账单相关接口--------//
///借款列表接口
let API_POST_MYLOANLIST                     = APP_SERVER_API + "/api/APPBizRest/myLoanList/v1/"
///判断是否借款接口
let API_POST_ISEXISTLOAN                    = APP_SERVER_API + "/api/APPBizRest/isExistLoan/v1/"
///借款详细接口
let API_POST_MYLOANLDETAIL                  = APP_SERVER_API + "/api/APPBizRest/myLoanDetail/v1/"
/// 2.3.7	完善资料咨询信息接口
let API_POST_PERFECTAPPLYINFO               = APP_SERVER_API + "/api/APPBizRest/perfectApplyInfo/v1/"
/// 2.3.9	提交资料咨询信息接口
let API_POST_SUBMITAPPLYINFO                = APP_SERVER_API + "/api/APPBizRest/submitApplyInfo/v1/"
/// 2.6.1	获取电子合同/废弃协议信息接口
let API_POST_QUERYELECTCONTRACT             = APP_SERVER_API + "/api/APPBizRest/queryElectContract/v1/"
/// 2.6.3	电子合同/废弃协议地址下载接口
let API_POST_DOWNLOADELECCONTRACT           = APP_SERVER_API + "/api/APPBizRest/downloadElecContract/v1/"
/// 2.6.2	用户返馈状态接口
let API_POST_USERSTATEFEEDBACK              = APP_SERVER_API + "/api/APPBizRest/userStateFeedBack/v1/"
/// 2.2.9	影像文件查询回显接口
let API_POST_QUERYBYTEFILESBYURL                = APP_SERVER_API + "/api/APPBizRest/queryByteFilesByUrl/v1/"
/// 历史借款列表接口
let API_POST_MYLOANHISTORY                  = APP_SERVER_API + "/api/APPBizRest/myLoanHistory/v1/"
/// 提额H5链接
let API_POST_MENTIONAMOUNT                  = APP_SERVER_API + "/repayH5/promoteAmountList.html"
//--------提现相关接口--------//
/// 查询渠道限额
let API_POST_RESTRICTION      = APP_SERVER_API + "/api/APPBizRest/cashRestriction/v1/"
/// 提现
let API_POST_CASHRECORD       = APP_SERVER_API + "/deposit/appCashRecord"
/// 查询用户信息（提现用身份证号）
let API_POST_CUSTOMERINFO     = APP_SERVER_API + "/api/APPBizRest/appCustomerInfo/v1/"
/// 查询是否有借款
let API_POST_ISHAVELOAN       = APP_SERVER_API + "/api/APPBizRest/isExistLoan/v1/"

//--------授权信息相关接口--------//
let API_POST_APPAUTHORIZEQUERY      = APP_SERVER_API + "/api/APPBizRest/appAuthorizeQuery/v1/"

//--------存管开户接口--------//
let API_POST_APPOPENDEPOSITORY      = APP_SERVER_API + "/deposit/appOpenDepository"

//let API_POST_APPOPENDEPOSITORY      = APP_SERVER_API + "/deposit/appOpenDepository"

//存管开户签署三方协议接口
let API_POST_APPAGREEMENT     = APP_SERVER_API+"/api/APPBizRest/appAgreement/v1"

//我的账户余额
let API_POST_APPMYACCOUNTINFO       = APP_SERVER_API + "/api/APPBizRest/myAccountInfo/v1/"


// MARK: - H5交互相关URL
//授权H5
let API_POST_H5_TICKET              = APP_SERVER_API+"/repayH5/ticket.html"
//完善资料
let API_POST_H5_PERFECTDATA         = APP_SERVER_API+"/repayH5/perfectData.html"
//完成认证界面
let API_POST_H5_AUZINFO         = APP_SERVER_API+"/repayH5/auzInfo.html"









