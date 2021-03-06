//
//  JYRefreshFooter.swift
//  NewEasyRepayment
//
//  Created by wenglx on 2017/9/14.
//  Copyright © 2017年 jieyuechina. All rights reserved.
//

import UIKit
import MJRefresh

class JYRefreshFooter: MJRefreshAutoNormalFooter {
    
    // MARK: - 初始化设置
    override func prepare() {
        super.prepare()
        isAutomaticallyChangeAlpha = true
        isRefreshingTitleHidden = true
        isAutomaticallyHidden = true
    }
    
    // MARK: - 设置控件位置
    override func placeSubviews() {
        super.placeSubviews()
    }

}
