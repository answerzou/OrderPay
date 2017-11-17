//
//  BaseModel.swift
//  NewEasyRepayment
//
//  Created by McIntosh on 2017/8/30.
//  Copyright © 2017年 jieyuechina. All rights reserved.
//

import Foundation

class BaseModel: NSObject {
    override init() {
        
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
