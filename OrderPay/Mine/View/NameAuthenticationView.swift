//
//  NameAuthenticationView.swift
//  OrderPay
//
//  Created by answer.zou on 17/11/4.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

class NameAuthenticationView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    override func draw(_ rect: CGRect) {
        UIView.addShadow(shadowColor: Shadow_backGroundColor ,shadowOffset: CGSize.init(width: 0, height: 2), shadowRadius: 3, shadowOpacity: 0.7, cornerRadius: 5, masksToBounds: true, toView: self.contentView)
    }
}
