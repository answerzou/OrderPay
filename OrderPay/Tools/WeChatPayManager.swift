//
//  WeChatPayManager.swift
//  OrderPay
//
//  Created by MAc on 2017/12/18.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

class WeChatPayManager: NSObject {
    class func initWeChatPayInfo() {
        WXApi.registerApp(WeChatPay_AppKey)
    }
}
