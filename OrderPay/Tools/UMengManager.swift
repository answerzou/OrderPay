//
//  UMengManager.swift
//  OrderPay
//
//  Created by MAc on 2017/12/14.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

class UMengManager: NSObject {
    
    class func initUmengInfo() {
        
        UMAnalyticsConfig.sharedInstance().appKey = UMENG_APPKEY
        UMAnalyticsConfig.sharedInstance().channelId = UMENG_CHANNELID
        
        let infoDic = Bundle.main.infoDictionary! as NSDictionary
        let version = infoDic.object(forKey: "CFBundleShortVersionString") as? String ?? ""
        MobClick.setAppVersion(version)
        MobClick.start(withConfigure: UMAnalyticsConfig.sharedInstance())
    }

}
