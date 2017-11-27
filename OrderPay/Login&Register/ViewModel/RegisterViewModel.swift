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
    
     class func requestData(params: NSDictionary, returnBlock: @escaping RegisterViewModelBolck) {
        CMRequestEngine.sharedInstance().post(withUrl: API_POST_REGISTER, parameters: params as! [AnyHashable : Any], type: .requestTypeRegister) { (tip, result) in
            if (tip?.success)! {
                SVProgressHUD.dismiss()
                returnBlock()
                
            }else {
                SVProgressHUD.showError(withStatus: tip?.errorDesc)
            }
        }
    }

}
