//
//  UserModel.swift
//  NewEasyRepayment
//
//  Created by McIntosh on 2017/8/30.
//  Copyright © 2017年 jieyuechina. All rights reserved.
//

import Foundation

private let JYUserDefault = UserDefaults.standard

class UserModel: BaseModel {
    // MARK:- 自定义属性
    static let shared = UserModel()
    
    /// 用户ID
    var userId:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userId")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userId") as? String
        }
    }
    
    /// 用户姓名
    var userName:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userName")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userName") as? String
        }
    }
    /// 身份证
    var cardNo:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userCardNo")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userCardNo") as? String
        }
    }
    /// 密码
    var passWord:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userPassWord")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userPassWord") as? String
        }
    }
    /// 手机号
    var mobile:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userMobile")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userMobile") as? String
        }
    }
    /// 客户姓名
    var custName:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userCustName")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userCustName") as? String
        }
    }
    /// 客户编号
    var custCode:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userCustCode")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userCustCode") as? String
        }
    }
    /// 申请金额
    var appAmount:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userAppAmount")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userAppAmount") as? String
        }
    }
    /// 申请期限
    var appPeriod:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userAppPeriod")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userAppPeriod") as? String
        }
    }
    
    /// 邀请码
    var inviteCode:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userInviteCode")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userInviteCode") as? String
        }
    }
    
    /// 城市编码cityCode 
    var cityCode:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userCityCode")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userCityCode") as? String
        }
    }
    
    /// 00  99为非存管：走非存管充值
    /// 01 华瑞  02 恒丰(目前暂无)  03向上 为存管：01 02走存管充值但是走非存管充值
    var isDepository: String? {
        set {
            JYUserDefault.set(newValue, forKey: "userDepository")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userDepository") as? String
        }
    }
    /// 存管银行是否开户 01：是 02：否
    var isOpenAccount:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userIsOpenAccount")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userIsOpenAccount") as? String
        }
    }
    /// 实名认证
    var consultId:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userConsultId")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userConsultId") as? String
        }
    }
    /// 绑卡银行编号
    var bankCode:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userBankCode")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userBankCode") as? String
        }
    }
    /// 绑卡银行名称
    var bankName:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userBankName")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userBankName") as? String
        }
    }
    /// 绑卡银行卡号
    var bankNo:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userBankNo")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userBankNo") as? String
        }
    }
    /// 绑卡银行手机号
    var acctPhone:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userAcctPhone")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userAcctPhone") as? String
        }
    }
    /// 账户余额
    var totalBalance:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userTotalBalance")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userTotalBalance") as? String
        }
    }
    /// 冻结余额
    var freezingAmount:String? {
        set {
            JYUserDefault.set(newValue, forKey: "userFreezingAmount")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userFreezingAmount") as? String
        }
    }
    /// 是否绑卡
    var isBindBankCard:Bool? {
        set {
            JYUserDefault.set(newValue, forKey: "userIsBindBankCard")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userIsBindBankCard") as? Bool
        }
    }

    /// 是否登录
    var isLogin:Bool? {
        set {
            JYUserDefault.set(newValue, forKey: "userIsLogin")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "userIsLogin") as? Bool
        }
    }
    ///
    
    // MARK:- 系统函数
    private override init() {
        super.init()
        userId = JYUserDefault.object(forKey: "userId") as? String ?? ""
        userName = JYUserDefault.object(forKey: "userName") as? String ?? ""
        cardNo = JYUserDefault.object(forKey: "userCardNo") as? String ?? ""
        passWord = JYUserDefault.object(forKey: "userPassWord") as? String ?? ""
        mobile = JYUserDefault.object(forKey: "userMobile") as? String ?? ""
        custName = JYUserDefault.object(forKey: "userCustName") as? String ?? ""
        custCode = JYUserDefault.object(forKey: "userCustCode") as? String ?? ""
        isDepository = JYUserDefault.object(forKey: "userDepository") as? String ?? ""
        isOpenAccount = JYUserDefault.object(forKey: "userIsOpenAccount") as? String ?? ""
        consultId = JYUserDefault.object(forKey: "userConsultId") as? String ?? ""
        bankCode = JYUserDefault.object(forKey: "userBankCode") as? String ?? ""
        bankName = JYUserDefault.object(forKey: "userBankName") as? String ?? ""
        bankNo = JYUserDefault.object(forKey: "userBankNo") as? String ?? ""
        acctPhone = JYUserDefault.object(forKey: "userAcctPhone") as? String ?? ""
        isLogin = JYUserDefault.object(forKey: "userIsLogin") as? Bool ?? false
        isBindBankCard = JYUserDefault.object(forKey: "userIsBindBankCard") as? Bool ?? false
        appAmount = JYUserDefault.object(forKey: "userAppAmount") as? String ?? ""
        appPeriod = JYUserDefault.object(forKey: "userAppPeriod") as? String ?? ""
        inviteCode = JYUserDefault.object(forKey: "userInviteCode") as? String ?? ""
        cityCode = JYUserDefault.object(forKey: "userCityCode") as? String ?? ""
        totalBalance = JYUserDefault.object(forKey: "userTotalBalance") as? String ?? ""
        freezingAmount = JYUserDefault.object(forKey: "userFreezingAmount") as? String ?? ""
    }
    
    deinit {
        JYAPPLog("---JYUserModeldeinit---")
    }
}

// MARK:- 对外提供方法
extension UserModel {
    /// 设置用户信息
    func setUserLoginInfo(dict: [String: Any]) {
        userId = "\(dict["userId"] ?? "")"
        userName = "\(dict["userName"] ?? "")"
        cardNo = "\(dict["cardNo"] ?? "")"
        custName = "\(dict["custName"] ?? "")"
        custCode = "\(dict["custCode"] ?? "")"
        isDepository = "\(dict["isDepository"] ?? "")"
        isOpenAccount = "\(dict["isOpenAccount"] ?? "")"
        consultId = "\(dict["consultId"] ?? "")"
    }
    
    func setUserBankInfo(dict: [String: Any]) {
        userName = "\(dict["userName"] ?? "")"
        bankCode = "\(dict["bankCode"] ?? "")"
        bankName = "\(dict["bankName"] ?? "")"
        bankNo = "\(dict["bankNo"] ?? "")"
        acctPhone = "\(dict["acctPhone"] ?? "")"
    }
    
    /*
    func saveUserealNameAuth(cardPersonDetailsModel:JYCardPersonDetailsModel?) {
        if cardPersonDetailsModel != nil {
            custName = cardPersonDetailsModel!.name as String
            cardNo = cardPersonDetailsModel!.idCardNumber as String
            consultId = cardPersonDetailsModel!.consultId as String
        }
    }
    */
    
    func saveUserBorrowingInformation(appAmount:String,appPeriod:String, inviteCode:String, cityCode:String) {
        self.appAmount = appAmount
        self.appPeriod = appPeriod
        self.inviteCode = inviteCode
        self.cityCode = cityCode
    }
    
    /*
     00  99  为非存管   01  02  03  是存管
     00  99  都走非存管模式充值  绑卡
     01  02  是存管   走存管模式充值  绑卡  开户
     03是向上 是存管   但  走存管的开户  ， 绑卡充值啥的  走非存管的
     */
    /// 用于判断用户：开户 -- true：存管 false：非存管
    func userAccountIsDepository() -> Bool {
        let isDepository = UserModel.shared.isDepository! as NSString
        if isDepository.isEqual(to: "01") || isDepository.isEqual(to: "02") || isDepository.isEqual(to: "03") {
            return true
        }
        return false
    }
    
    /// 用于判断用户：绑卡、充值、查询 -- true：存管 false：非存管
    func userOtherIsDepository() -> Bool {
        let isDepository = UserModel.shared.isDepository! as NSString
        if isDepository.isEqual(to: "01") || isDepository.isEqual(to: "02"){
            return true
        }
        return false
    }
    
    /// 用于判断向上
    func istoTop() -> Bool {
        let isDepository = UserModel.shared.isDepository! as NSString
        if isDepository.isEqual(to: "03"){
            return true
        }
        return false
    }
    
    /// 存管用户是否开户
    func depositoryUserIsOpenAccount() ->Bool {
        let isOpenAccount = UserModel.shared.isOpenAccount! as NSString
        if isOpenAccount.isEqual(to: "01") {
            return true
        }
        return false
    }
    
    /// 清除用户信息
    func clearUserInfo() {
        userId = nil
        userName = nil
        cardNo = nil
        passWord = nil
        mobile = nil
        custName = nil
        custCode = nil
        isDepository = nil
        isOpenAccount = nil
        consultId = nil
        bankCode = nil
        bankName = nil
        bankNo = nil
        acctPhone = nil
        appAmount = nil
        appPeriod = nil
        cityCode = nil
        inviteCode = nil
        totalBalance = nil
        freezingAmount = nil
        isLogin = false
        isBindBankCard = false
    }
}
