//
//  LoginHeaderView.swift
//  OrderPay
//
//  Created by answer.zou on 17/11/5.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

typealias LoginBtnClick = (_ account: String?, _ passwd: String?)-> Void
typealias RegisterBtnClick = ()->()
typealias ForgetBtnClick = () -> Void

class LoginHeaderView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var accountStr: String = ""
    var passwordStr: String = ""
    
    var loginBtnClick: LoginBtnClick?
    var registerBtnClick: RegisterBtnClick?
    var forgetBtnClick: ForgetBtnClick?
    
    override func draw(_ rect: CGRect) {
        UIView.addShadow(shadowColor: Shadow_backGroundColor ,shadowOffset: CGSize.init(width: 0, height: 2), shadowRadius: 3, shadowOpacity: 0.7, cornerRadius: 5, masksToBounds: true, toView: self.contentView)
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        
        self.endEditing(true)
        
        if JYUtilities.verifyPhoneNumber(self.accountTextField.text) == false {
            SVProgressHUD.showError(withStatus: "请输入正确手机号")
            return
        }
        
        if (loginBtnClick != nil) {
            self.loginBtnClick!(self.accountStr, self.passwordStr)
        }

    }
    @IBAction func registerAction(_ sender: UIButton) {
        if (registerBtnClick != nil) {
            self.registerBtnClick!()
        }
    }
    
    @IBAction func fogetPasswordBtnAction(_ sender: UIButton) {
        if forgetBtnClick != nil{
            self.forgetBtnClick!()
        }
    }
    
    
}

extension LoginHeaderView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let nsString = textField.text as NSString?
        let newString = nsString?.replacingCharacters(in: range, with: string)
        
        switch textField.tag {
        case AccountTF:
            self.accountStr = newString ?? ""
        default:
            self.passwordStr = newString ?? "" 
            
            if self.accountStr.isEmpty || self.passwordStr.isEmpty {
                loginBtn.isEnabled = false
            }else {
                loginBtn.isEnabled = true
            }
        }
        return true
    }
}
