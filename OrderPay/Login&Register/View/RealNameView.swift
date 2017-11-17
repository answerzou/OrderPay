//
//  RealNameView.swift
//  OrderPay
//
//  Created by answer.zou on 17/11/8.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

typealias RegisterBtnBlock = ()->()

class RealNameView: UIView {
    @IBOutlet weak var contenView: UIView!

    @IBOutlet weak var realNameTextField: UITextField!
    
    @IBOutlet weak var idCardTextField: UITextField!

    @IBOutlet weak var inviteCodeTextField: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var registerBtnBlock: RegisterBtnBlock?

    
    @IBAction func registerBtnAction(_ sender: UIButton) {
        
        if self.registerBtnBlock != nil {
            self.registerBtnBlock!()
        }
    }
    
    override func draw(_ rect: CGRect) {
        UIView.addShadow(shadowColor: Shadow_backGroundColor ,shadowOffset: CGSize.init(width: 0, height: 2), shadowRadius: 3, shadowOpacity: 0.7, cornerRadius: 5, masksToBounds: true, toView: self.contenView)
    }
   
}
