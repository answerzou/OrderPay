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
    
    class func requestData(headerView: RealNameView, params: NSDictionary, returnBlock: @escaping LoginViewModelBlock) {
        CMRequestEngine.sharedInstance().post(withUrl: API_POST_LOGIN, parameters: params as! [AnyHashable : Any], type: .requestTypeLogin) { (tip, result) in
            if (tip?.success)! {
                SVProgressHUD.dismiss()
                returnBlock()
                
            }else {
//                headerView.registerBtn.setTitle("注册", for: .normal)
//                headerView.indicatorView.stopAnimating()
//                headerView.registerBtn.isEnabled = true
                SVProgressHUD.showError(withStatus: tip?.errorDesc)
            }
        }
    }

}
