//
//  RegisterViewModel.swift
//  OrderPay
//
//  Created by MAc on 2017/11/27.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

typealias RegisterViewModelBolck = () ->()

class RegisterViewModel: NSObject {
    
    class func requestData(headerView: RegisterHeaderView, params: NSDictionary, returnBlock: @escaping RegisterViewModelBolck) {
        CMRequestEngine.sharedInstance().post(withUrl: API_POST_REGISTER, parameters: params as! [AnyHashable : Any], type: .requestTypeRegister) { (tip, result) in
            if tip?.success == true {
                SVProgressHUD.dismiss()
                
                //注册成功用户
                
                MobClick.event(UMengCustomEvent_App_Register)
                
                let resultDic = result as! NSDictionary
                print(resultDic)
                print(resultDic.object(forKey: "custCode") as? String)
                
                //客户编码和手机号存本地
                UserModel.shared.custCode = resultDic.object(forKey: "custCode") as? String 
                UserModel.shared.mobile = params.object(forKey: "mobile") as? String
                returnBlock()
                
            }else {
                headerView.registerBtn.setTitle("确定", for: .normal)
                headerView.indicatorView.stopAnimating()
                headerView.registerBtn.isEnabled = true
                SVProgressHUD.showError(withStatus: tip?.errorDesc)
            }
        }
    }

}
