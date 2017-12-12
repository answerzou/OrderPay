//
//  CMResponseTip.h
//  LoanInternalPlus
//
//  Created by sandy on 2017/8/14.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, JYRequestError){
    JYRequestErrorLoseParam     =   -10000,
    JYRequestErrorLoseSession,
    JYRequestErrorSameInQueue,
    JYRequestErrorJsonFormat,
    JYRequestErrorTimeOut,
    JYRequestErrorHostNotReach,
    JYRequestErrorCancel,               //取消请求
    
    JYRequestErrorNone          =   200,//无错误
};

//type for request type
typedef NS_ENUM(NSInteger, JYRequestType){
    JYRequestTypeLogin = 1000,       //login
    JYRequestTypeGetPhoneMsg,       //获取短信验证码
    JYRequestTypeRegister,          //注册ENQUIRYPRICELIST
    JYRequestTypeResetPwd,          //重置密码
    JYRequestTypeSaveMobileInformation, //保存手机相关信息
    JYRequestTypeGoUpAPPVersion, //版本校验升级
    JYRequestTypeSaveAddressBooks, //保存用户通讯录
    JYRequestTypeSaveMobileAddress, //保存地理位置相关信息
    JYRequestTypeEnquirypriceExaminingList,          //审核中列表
    JYRequestTypeEnquirypriceExaminedList,          //审核完成列表
    JYRequestTypeUpLoadFileZip,         //上传影像
    JYRequestTypeQueryOneSideCardInfo,         //身份证OCR识别（单面）
    JYRequestTypeQueryTwoSideCardInfo,         //身份证OCR识别（双面）contrastSourceInfo
    JYRequestTypeAppRegister,         //实名认证
    JYRequestTypeContrastSourceInfo,         //有源对比照片对比接口
    JYResponseTypeSignCenterList,                    //测试签到列表
    JYRequestTypeLoginCheckUpgrade,                  //检查是否有新版本
    JYRequestTypeBanQuery,                   //检查是否绑定银行卡
    JYRequestTypeBankUnlock,                   //解绑银行卡
    JYRequestTypeBankCardNo,                   //银行名称返显
    JYRequestTypeBankAll,                   //全部银行名称
    JYRequestTypeRechargeQuery,                   //充值记录查询
    JYRequestTypeCashRecordQuery,                   //提现记录查询
    JYRequestTypeRestriction,                       //查询渠道限额
    JYRequestTypeCashRecord,                        //提现
    JYRequestTypeMyLoanList,                   //账单列表接口
    JYRequestTypeMyLoanDetail,                   //账单详情
    JYRequestTypePerfectApplyInfo,                  //2.3.5	完善资料咨询信息接口
    JYRequestTypeSubmitApplyInfo,                   //2.3.9	提交资料咨询信息接口
    JYRequestTypeQueryElectContract,                //2.6.1	获取电子合同/废弃协议信息接口
    JYRequestTypeDownloadElecContract,              //2.6.3	电子合同/废弃协议地址下载接口
    JYRequestTypeUserStateFeedBack,                 //2.6.2	用户返馈状态接口
    JYRequestTypeQueryByteFilesByUrl,               //2.2.9	影像文件查询回显接口
//    JYRequestTypeRechargeQuery,                   //还款记录查询(没有接口)
    JYRequestTypeFastPaymentType,               //开通快捷支付
    JYRequestTypeNonDepositoryBankPreBindingype,                //非存管银行卡预绑定
    JYRequestTypeBindBankCardType,              //非存管是否绑卡
    JYRequestTypeNonDepositoryBankConfirmBindingype,                //非存管银行卡确认绑定
    JYRequestTypeRestrictionTye,         //贷款
    JYRequestTypeNonDepositoryConfirmRechageType,               //非存管确认充值
    JYRequestTypeaNonDepositoryPreRechargeType,              //非存管预充值
    JYRequestTypeCustomerInfo,                   //用户信息查询
    JYRequestTypeIsHaveLoan,                 //查询用户是否有借款
    JYRequestTypeAuthorizeQueryType,         //授权信息查询
    JYRequestTypeAppOpenDepositoryType,      //存管开户
    JYRequestTypeAppAgreementType,         //开户签署三方协议
    JYRequestTypeMyLoanHistory,         //我的历史记录
    JYRequestTypeMyAccountInfo,         //我的账户余额
    JYRequestTypeAccountInfo,              //查询用户可用余额
    JYRequestTypeMyGetList,              //我的订单
    
};
//type for request flag
typedef NS_ENUM(NSInteger, JYRequestFlag){
    JYRequestFlagLogin = 3000,       //login
    JYRequestFlagGetPhoneMsg,       //获取短信验证码
    JYRequestFlagRegister,          //注册
    JYRequestFlagEnquirypriceExaminingList,          //审核中列表
    JYRequestFlagEnquirypriceExaminedList,          //审核完成列表
    
    JYResponseFlagSignCenterList,                    //测试签到列表
    JYRequestFlagLoginCheckUpgrade                   //检查是否有新版本

};
/***************************Response********************************/
#define KResponseTip    @"ResponseTip"
#define KTransferData   @"TransferData"
#define KResponseBody   @"responseBody"
/******************************************************************/

@interface CMResponseTip : NSObject
/**
 合作商企业ID 合作商方的企业ID，由捷越联合贷款提供
 */
@property (nonatomic , copy)NSString * JYCID;

/**
 合作商标识 合作商编号，由捷越联合贷款提供
 */
@property (nonatomic , copy)NSString * JYPTID;

/**
 登录用户名
 */
@property (nonatomic , copy)NSString * userName;
/**
 请求时间  请求时间格式为：yyyy-MM-dd HH:mm:ss
 */
@property (nonatomic , copy)NSString * reqTime;

@property (nonatomic , assign)BOOL success;

/**
 接口返回失败后的异常信息	接口返回失败后的异常信息
 */
@property (nonatomic , copy)NSString * errorDesc;
/**
 接口返回失败后的异常信息	接口返回失败后的异常信息
 */
@property (nonatomic , copy)NSString * retCode;
/**
 错误代码
 */
@property (nonatomic,assign)    JYRequestError errorCode;        //response code
/**
 请求代码
 */
@property (nonatomic,assign)    JYRequestType requestCode;        //response code
/**
 请求类型
 */
@property (nonatomic,assign)    NSInteger type;        //request type
@property (nonatomic,assign)    NSInteger subtype;     //sub type

/**
 请求标识（为准确cancel请求）
 */
@property (nonatomic,copy)      NSString* flag;        //request flag
/**
 设置错误代码和错误信息
 
 @param cd 错误代码
 @param er 错误信息
 */
- (void)setWithWithCode:(NSInteger)cd error:(NSString*)er;

/**
 每次请求的公用回调
 
 @param callback 公用回调
 */
- (void)processError:(void (^)(void))callback;
@end
