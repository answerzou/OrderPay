//
//  RealNameViewModel.swift
//  OrderPay
//
//  Created by answer.zou on 2017/12/11.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit
typealias RealNameViewModelBolck = () ->()

class RealNameViewModel: NSObject {
    class func requestData(headerView: RealNameView, params: NSDictionary, returnBlock: @escaping RealNameViewModelBolck) {
        CMRequestEngine.sharedInstance().post(withUrl: API_POST_APPAUTH, parameters: params as! [AnyHashable : Any], type: .requestTypeAppRegister) { (tip, result) in
            if (tip?.success)! {
                
                //let params = ["pid": pid, "custCode": custCode, "mobile": mobile, "name": name, "cardNo": cardNo, "cityCode": cityCode, "companyName": companyName]
                UserModel.shared.cardNo = params["cardNo"] as? String
                UserModel.shared.cityCode = params["cityCode"] as? String
                UserModel.shared.companyName = params["companyName"] as? String
                SVProgressHUD.dismiss()
                returnBlock()
                
            }else {
                headerView.registerBtn.setTitle("实名认证", for: .normal)
                headerView.indicatorView.stopAnimating()
                headerView.registerBtn.isEnabled = true
                SVProgressHUD.showError(withStatus: tip?.errorDesc)
            }
        }
    }
}
