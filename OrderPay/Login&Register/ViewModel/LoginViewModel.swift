//
//  LoginViewModel.swift
//  OrderPay
//
//  Created by MAc on 2017/11/28.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

typealias LoginViewModelBlock = () -> ()
class LoginViewModel: NSObject {
    
    class func requestData(headerView: LoginHeaderView, params: NSDictionary, returnBlock: @escaping LoginViewModelBlock) {
        CMRequestEngine.sharedInstance().post(withUrl: API_POST_LOGIN, parameters: params as! [AnyHashable : Any], type: .requestTypeLogin) { (tip, result) in
            if tip?.success == true {
                
                UserModel.shared.setUserLoginInfo(dict: result as! Dictionary)
                SVProgressHUD.dismiss()
                
                //登录成功获取通讯录权限
                AddressBookTools.addressBookRequestAccess()
                returnBlock()
                
            }else {
                headerView.loginBtn.setTitle("登录", for: .normal)
                headerView.indicatorView.stopAnimating()
                headerView.loginBtn.isEnabled = true
                SVProgressHUD.showError(withStatus: tip?.errorDesc)
            }
        }
    }

}
