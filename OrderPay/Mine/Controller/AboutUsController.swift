//
//  AboutUsController.swift
//  OrderPay
//
//  Created by MAc on 2017/12/18.
//  Copyright © 2017年 answer.zou. All rights reserved.
//  关于我们

import UIKit

class AboutUsController: CMBaseWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.cleanWebViewCache()
        
        let path = Bundle.main.path(forResource: "company", ofType: "html")
        let url = URL.init(fileURLWithPath: path!)
        let reuqest = URLRequest.init(url: url)
        
        self.webView.load(reuqest)
    }

}
