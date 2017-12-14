//
//  OrderViewModel.swift
//  OrderPay
//
//  Created by MAc on 2017/12/12.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias OrderViewModelBolck = (NSArray, Bool, NSInteger) ->()

class OrderViewModel: NSObject {
    class func requestData(params: NSDictionary, returnBlock: @escaping OrderViewModelBolck) {
        CMRequestEngine.sharedInstance().post(withUrl: API_POST_MYGETLIST, parameters: params as! [AnyHashable : Any], type: .requestTypeMyGetList) { (tip, result) in
            if tip?.success == true {
                SVProgressHUD.dismiss()
                
                let resultDic = result as! NSDictionary
                let modelArray = OrderModel.mj_objectArray(withKeyValuesArray: resultDic["detailList"])
                
                returnBlock(modelArray!, true, resultDic.object(forKey: "totalRows") as! NSInteger)
                
            }else {
                
                returnBlock(NSArray(), false, 0)
                SVProgressHUD.showError(withStatus: tip?.errorDesc)
            }
        }
    }
}
