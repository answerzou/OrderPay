//
//  SmCodeViewModel.swift
//  OrderPay
//
//  Created by MAc on 2017/11/27.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

typealias SmCodeViewModelBolck = () ->()
class SmCodeViewModel: NSObject {
    
    
    class func requestData(params: NSDictionary, returnBlock: @escaping SmCodeViewModelBolck) {

        SVProgressHUD.show()
        
        
        CMRequestEngine.sharedInstance().post(withUrl: API_POST_VERIFICATION, parameters: params as! [AnyHashable : Any], type: .requestTypeGetPhoneMsg) { (tip, result) in
            
            if tip?.success == true {
                
                SVProgressHUD.showSuccess(withStatus: "验证码已发送，注意查收")
                returnBlock()
                
            }else {
                SVProgressHUD.showError(withStatus: tip?.errorDesc)
            }
        }
            
    }

}
