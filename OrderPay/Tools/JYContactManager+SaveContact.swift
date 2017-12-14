//
//  JYContactManager+SaveContact.swift
//  NewEasyRepayment
//
//  Created by mcintosh on 2017/9/26.
//  Copyright © 2017年 jieyuechina. All rights reserved.
//

import UIKit


extension JYContactManager {
    
    
    //MARK: - 保存手机通讯录
    class func saveContanctInfo(_ contactArr:NSArray) {
        if contactArr.count == 0 {
            return
        }
      
        var parameters:[String: Any] = [String : Any]()
        parameters["custCode"] = UserModel.shared.custCode
        parameters["pid"] = UIDevice.current.identifierForVendor?.uuidString ?? ""
        let cdicArr = NSMutableArray()
        for model in contactArr {
            if let model = model as? JYAddressBookModel{
                let dic:NSMutableDictionary = NSMutableDictionary()
                dic.setValue(model.name, forKey: "name")
                dic.setValue(model.telephone1, forKey: "telephone1")
                dic.setValue(model.telephone2, forKey: "telephone2")
                dic.setValue(model.telephone3, forKey: "telephone3")
                cdicArr.add(dic)
            }
        }
        parameters["addressBooks"] = cdicArr as AnyObject?
        JYAPPLog(parameters)
    
        CMRequestEngine.sharedInstance().post(withUrl:API_POST_SAVEADDRESSBOOKS, parameters: parameters, type: JYRequestType.requestTypeSaveAddressBooks) { (tip, obj) in
            if tip?.success == true {
                JYAPPLog("保存手机相关信息成功")
            }else{
                JYAPPLog(tip?.errorDesc)
            }
        }

    }
    
}
