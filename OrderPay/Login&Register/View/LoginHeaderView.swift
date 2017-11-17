//
//  LoginHeaderView.swift
//  OrderPay
//
//  Created by answer.zou on 17/11/5.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

typealias LoginBtnClick = ()->()
typealias RegisterBtnClick = ()->()


class LoginHeaderView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var accountStr: String?
    var passwordStr: String?
    
    var loginBtnClick: LoginBtnClick?
    var registerBtnClick: RegisterBtnClick?
    
    override func draw(_ rect: CGRect) {
        UIView.addShadow(shadowColor: Shadow_backGroundColor ,shadowOffset: CGSize.init(width: 0, height: 2), shadowRadius: 3, shadowOpacity: 0.7, cornerRadius: 5, masksToBounds: true, toView: self.contentView)
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        if (loginBtnClick != nil) {
            self.loginBtnClick!()
        }

    }
    @IBAction func registerAction(_ sender: UIButton) {
        if (registerBtnClick != nil) {
            self.registerBtnClick!()
        }
    }
    
}

extension LoginHeaderView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("xxx")
        
        let nsString = textField.text as NSString?
        let newString = nsString?.replacingCharacters(in: range, with: string)
        
        if (newString?.isEmpty)! && (self.accountTextField.text?.isEmpty)!{
            loginBtn.isEnabled = false
        }else {
            loginBtn.isEnabled = true
        }
        
        
        let expression = "^-{0,1}[0-9]*((\\.|,)[0-9]{0,2})?$"
        let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
        let numberOfMatches = regex.numberOfMatches(in: newString!, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, (newString! as NSString).length))
        
        return numberOfMatches != 0
        
    }
}
