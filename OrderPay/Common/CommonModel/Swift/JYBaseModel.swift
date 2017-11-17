//
//  JYBaseModel.swift
//  NewEasyRepayment
//
//  Created by mcintosh on 2017/9/17.
//  Copyright © 2017年 jieyuechina. All rights reserved.
//

import UIKit

class JYBaseModel: NSObject {

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if (value is String){
            super.setValue(value, forKey: key)
        }else {
            let vv = (value != nil) ? value! : ""
            var vvStr = "\(vv)"
            if vvStr.contains("."){
                let vD = value as! Double
                vvStr = "\(vD)"
            }
            super.setValue("\(vvStr)", forKey: key)
        }
    }
    
}
