//
//  OrderViewModel.swift
//  OrderPay
//
//  Created by MAc on 2017/12/12.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias OrderViewModelBolck = (NSArray, Bool) ->()

class OrderViewModel: NSObject {
    class func requestData(params: NSDictionary, returnBlock: @escaping OrderViewModelBolck) {
        CMRequestEngine.sharedInstance().post(withUrl: API_POST_MYGETLIST, parameters: params as! [AnyHashable : Any], type: .requestTypeMyGetList) { (tip, result) in
            if (tip?.success)! {
                SVProgressHUD.dismiss()
                
                let resultDic = result as! NSDictionary
//                let model = OrderModel()
//                let dataJson = JSON(result)["detailList"].rawValue
               let modelArray = OrderModel.mj_objectArray(withKeyValuesArray: resultDic["detailList"])
                print(modelArray)
                print(result)
//                let dataDic = 
//                print(resultDic)
//                
                returnBlock(modelArray!, true)
                
            }else {
                
                returnBlock(NSArray(), false)
//                headerView.registerBtn.setTitle("确定", for: .normal)
//                headerView.indicatorView.stopAnimating()
//                headerView.registerBtn.isEnabled = true
                SVProgressHUD.showError(withStatus: tip?.errorDesc)
            }
        }
    }
}
