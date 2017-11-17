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

    static let instance = JYCommonObj() //这个位置使用 static，static修饰的变量会懒加载
    
//    fileprivate override init(){
//        JYAPPLog("create JYCommonObj...");
//        appUUID = ""
//    }
    
    
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
//        JYNetRequestLogic.requestAppAPI(API_POST_SAVE_CONTACTS, body: contactDic as NSDictionary) { ( dic, error) -> Void in
//            if((dic) != nil){
//                let ddd: String = dic!["retCode"]! as! String
//                if Int(ddd) != 200 {
////                    SVProgressHUD.showInfoWithStatus(dic!["errorDesc"]! as! String)
//                }else {
//                    JYAPPLog("保存手机通讯录")
//                }
//            }else{
//                JYAPPLog("保存手机通讯录失败了")
//            }
//        }
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






