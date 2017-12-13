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
    
    /// 用户状态
    var authStatus:String? {
        set {
            JYUserDefault.set(newValue, forKey: "authStatus")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "authStatus") as? String
        }
    }
    
    /// 用户姓名
    var name:String? {
        set {
            JYUserDefault.set(newValue, forKey: "name")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "name") as? String
        }
    }
    /// 身份证
    var cardNo:String? {
        set {
            JYUserDefault.set(newValue, forKey: "cardNo")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "cardNo") as? String
        }
    }
    /// 城市
    var city:String? {
        set {
            JYUserDefault.set(newValue, forKey: "city")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "city") as? String
        }
    }
    /// 手机号
    var mobile:String? {
        set {
            JYUserDefault.set(newValue, forKey: "mobile")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "mobile") as? String
        }
    }
    /// 城市名称
    var cityName:String? {
        set {
            JYUserDefault.set(newValue, forKey: "cityName")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "cityName") as? String
        }
    }
    /// 公司名称
    var companyName:String? {
        set {
            JYUserDefault.set(newValue, forKey: "companyName")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "companyName") as? String
        }
    }
    /// custCode
    var custCode:String? {
        set {
            JYUserDefault.set(newValue, forKey: "custCode")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "custCode") as? String
        }
    }
    /// 介绍人
    var introducer:String? {
        set {
            JYUserDefault.set(newValue, forKey: "introducer")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "introducer") as? String
        }
    }
    
    /// 别名
    var nickName:String? {
        set {
            JYUserDefault.set(newValue, forKey: "nickName")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "nickName") as? String
        }
    }
    
    ///城市编码
    var cityCode:String? {
        set {
            JYUserDefault.set(newValue, forKey: "cityCode")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "cityCode") as? String
        }
    }
    
    
    
    /// VIP开始时间
    var strVipBeginTime:String? {
        set {
            JYUserDefault.set(newValue, forKey: "strVip BeginTime")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "strVipBeginTime") as? String
        }
    }

    /// VIP结束时间
    var strVipEndTime: String? {
        set {
            JYUserDefault.set(newValue, forKey: "strVipEndTime")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "strVipEndTime") as? String
        }
    }
   
    ///pid
    var pid: String? {
        set {
            JYUserDefault.set(newValue, forKey: "pid")
            JYUserDefault.synchronize()
        }
        get {
            return JYUserDefault.object(forKey: "pid") as? String
        }
    }
    
    // MARK:- 系统函数
    private override init() {
        super.init()
        authStatus = JYUserDefault.object(forKey: "authStatus") as? String ?? ""
        name = JYUserDefault.object(forKey: "name") as? String ?? ""
        cardNo = JYUserDefault.object(forKey: "cardNo") as? String ?? ""
        city = JYUserDefault.object(forKey: "city") as? String ?? ""
        mobile = JYUserDefault.object(forKey: "mobile") as? String ?? ""
        cityName = JYUserDefault.object(forKey: "cityName") as? String ?? ""
        companyName = JYUserDefault.object(forKey: "companyName") as? String ?? ""
        custCode = JYUserDefault.object(forKey: "custCode") as? String ?? ""
        introducer = JYUserDefault.object(forKey: "introducer") as? String ?? ""
        nickName = JYUserDefault.object(forKey: "nickName") as? String ?? ""
        strVipBeginTime = JYUserDefault.object(forKey: "strVipBeginTime") as? String ?? ""
        strVipEndTime = JYUserDefault.object(forKey: "strVipEndTime") as? String ?? ""
        cityCode = JYUserDefault.object(forKey: "cityCode") as? String ?? ""
        pid = JYUserDefault.object(forKey: "pid") as? String ?? ""
    }
    
    deinit {
        JYAPPLog("---JYUserModeldeinit---")
    }
}

// MARK:- 对外提供方法
extension UserModel {
    /// 设置用户信息
    func setUserLoginInfo(dict: [String: Any]) {
        authStatus = "\(dict["authStatus"] ?? "")"
        cardNo = "\(dict["cardNo"] ?? "")"
        city = "\(dict["city"] ?? "")"
        custCode = "\(dict["custCode"] ?? "")"
        cityName = "\(dict["cityName"] ?? "")"
        companyName = "\(dict["companyName"] ?? "")"
        introducer = "\(dict["introducer"] ?? "")"
        mobile = "\(dict["mobile"] ?? "")"
        name = "\(dict["name"] ?? "")"
        nickName = "\(dict["nickName"] ?? "")"
        strVipBeginTime = "\(dict["strVipBeginTime"] ?? "")"
        strVipEndTime = "\(dict["strVipEndTime"] ?? "")"
    }
 
    /// 清除用户信息
    func clearUserInfo() {
        authStatus = nil
        cardNo = nil
        city = nil
        cityName = nil
        companyName = nil
        custCode = nil
        introducer = nil
        mobile = nil
        name = nil
        nickName = nil
        strVipBeginTime = nil
        strVipEndTime = nil
        cityCode = nil
        pid = nil
    }
}
