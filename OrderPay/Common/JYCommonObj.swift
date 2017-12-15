 //
//  JYCommonObj.swift
//  EasyRepayment
//
//  Created by McIntosh on 16/1/20.
//  Copyright © 2016年 捷越联合. All rights reserved.
//

import Foundation
import AddressBook

class JYCommonObj : NSObject {
    
//    var appUUID: String?
//    var loginNew:Bool = false
//    var autoLogin:Bool = false
//    var loginSuccess:Bool = false
    var addressBook:ABAddressBook?
    
    fileprivate var timer:Timer?
    var updateURL:String?

    static let instance = JYCommonObj() //这个位置使用 static，static修饰的变量会懒加载
    
    
    class func showChangePassword(_ title:String?,content:String?,delegate:AnyObject?) {
        let alertView = UIAlertView()
        alertView.title = title!
        alertView.message = content
        alertView.delegate=delegate;
        alertView.tag = 4
        alertView.addButton(withTitle: "取消")
        alertView.addButton(withTitle: "修改密码")
        alertView.cancelButtonIndex=0
        alertView.show()
    }
    
    //MARK:版本验证
    func appVersionCheck() {
        let pid = UserModel.shared.pid ?? ""
        let parameters:NSDictionary = ["appVersion":JYAppVerionNum,
                                       "operatSystem":"ios",
                                       "pid": pid]

        CMRequestEngine.sharedInstance().post(withUrl: API_POST_UPAPPVERSION, parameters:parameters as! [AnyHashable : Any], type: JYRequestType.requestTypeGoUpAPPVersion) { (tip, obj) in
            if tip?.success == true {
                let userDic = obj as? NSDictionary
                if userDic?["forceState"] as? String == "0" {
                    return
                }
//                if userDic?["forceState"] as? String=="2" {
//                    appDelegate.logoutApp()
//                }
                self.updateURL = (userDic?["appDownUrl"] as? String)
                JYCommonObj.showUpdateVersion(self,type:userDic?["forceState"] as? String, content:userDic?["versionContent"] as? String)
                JYAPPLog("\(userDic)")
            }else{
                JYAPPLog("失败了")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                   // self.reAppVersionCheck()
                })
            }
        }
    }
    
    func reAppVersionCheck() {
        let pid = UserModel.shared.pid ?? ""
        let parameters:NSDictionary = ["appVersion":JYAppVerionNum,
                                       "operatSystem":"ios",
                                       "pid": pid]
        CMRequestEngine.sharedInstance().post(withUrl: API_POST_UPAPPVERSION, parameters:parameters as! [AnyHashable : Any], type: JYRequestType.requestTypeGoUpAPPVersion) { (tip, obj) in
            if tip?.success == true {
                let userDic = obj as? NSDictionary
                if userDic?["forceState"] as? String=="0" {
                    return
                }
//                if userDic?["forceState"] as? String=="2" {
//                    appDelegate.logoutApp()
//                }
                self.updateURL = (userDic?["appURL"] as? String)
                JYCommonObj.showUpdateVersion(self,type:userDic?["forceState"] as? String, content:userDic?["versionContent"] as? String)
                JYAPPLog("\(userDic)")
            }else{
                JYAPPLog("失败了")
            }
        }
    }
    
    //MARK: - 保存手机通讯录
    class func saveContanctInfo(_ contactArr:NSArray) {
        if contactArr.count == 0 {
            return
        }
      
        var contactDic = [String:AnyObject]()
        var cdicArr = [Dictionary<String,AnyObject>]()
        for contanctObt: AnyObject in contactArr as [AnyObject] {
            var contanctDic = [String:String]()
            let carrr = contanctObt["Phone"]
            var index = 1
            contanctDic["name"] = contanctObt["fullName"]! as? String
            for phoneN in carrr as! Array<AnyObject> {
                contanctDic["telephone\(index)"] = phoneN as? String
                index += 1
            }
            cdicArr.append(contanctDic as [String : AnyObject])
        }
        contactDic["addressBooks"] = cdicArr as AnyObject?
        print(contactDic)
    }
    
    //AES加密
    class func aes_encryptData(_ dataDic:NSDictionary) ->String? {
        let jsonStr = JYUtilities.dictionary(toJson: dataDic as! [AnyHashable: Any])
        let aesStr = AESCrypt.encrypt(jsonStr, password:AESBodyKey)
        if (aesStr != nil) {
            return aesStr
        }
        return ""
    }
    
    //AES解密
    class func aes_decryptData(_ dataStr:String) -> NSDictionary? {
        let jsonStr = AESCrypt.decrypt(dataStr, password:AESDecryptKey)
        let dic = JYUtilities.dictionary(withJsonString: jsonStr)
        return dic as NSDictionary?
    }
    
    
        /// 缩放
    /// - Parameters:
    ///   - selectV: 需要缩放的view
    class func transform3DScale(selectV:UIView,from:CGFloat,to:CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {
            // 初始化3D变换,获取默认值
            var perspectiveTransform = CATransform3DIdentity
            // 空间缩放
            perspectiveTransform = CATransform3DScale(perspectiveTransform, from, from, 1)
            selectV.layer.transform = perspectiveTransform
        }) { (bool) in
            UIView.animate(withDuration: 0.2, animations: {
                // 初始化3D变换,获取默认值
                var perspectiveTransform = CATransform3DIdentity
                // 空间缩放
                perspectiveTransform = CATransform3DScale(perspectiveTransform, to, to, 1)
                selectV.layer.transform = perspectiveTransform
            })
        }
    }
    
    
}
 
 extension JYCommonObj{
    class func showUpdateVersion(_ delegate:AnyObject,type:String?,content:String?){
        let alertView = UIAlertView()
        alertView.title = "更新"
        alertView.message = content
        alertView.addButton(withTitle: "确定")
        alertView.delegate=delegate;
        
        //强制升级
        if(type=="2"){
            alertView.tag = 1
        }else{
            
            //非强制升级
            alertView.tag = 0
            alertView.addButton(withTitle: "取消")
        }
        alertView.show()
    }
    
 }
 
 extension JYCommonObj {
    func alertView(_ alertView:UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        
        
        if(alertView.tag==0){
            if(buttonIndex==0){
                JYAPPLog("updatURL:\(updateURL ?? "")")
                if let updateURL = updateURL{
                    if let openUrl = URL(string: updateURL){
                        UIApplication.shared.openURL(openUrl)
                    }
                }
            }
        }else if(alertView.tag==1){
            JYAPPLog("点击了好")
            JYAPPLog("updatURL:\(updateURL ?? "")")
            if let updateURL = updateURL{
                if let openUrl = URL(string: updateURL){
                    UIApplication.shared.openURL(openUrl)
                }
            }
        }else if(alertView.tag==2){
            if(buttonIndex==alertView.cancelButtonIndex){
                JYAPPLog("点击了取消")
            }else {
                
            }
        }
    }
    
 }






