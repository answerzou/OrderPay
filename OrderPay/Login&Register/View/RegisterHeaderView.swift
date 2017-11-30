//
//  RegisterHeaderView.swift
//  OrderPay
//
//  Created by answer.zou on 17/11/5.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

let type_register = "1"
let type_forgetPsd = "2"
typealias NextStepClick = ()->()

let AccountTF = 0
let PasswordTF = 1
let ConfirmPasswordTF = 2
let SMCodeTF = 3

class RegisterHeaderView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verificationCodeField: UITextField!
    @IBOutlet weak var verificationCodeBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var confirPasswordBottomLine: UIView!
    @IBOutlet weak var confirPasswordTextField: UITextField!
    
    ///是否是找回密码
    var forgetPassword: Bool = false
    
    ///账号Str
    var accountStr: String = ""
    ///密码Str
    var passwordStr: String = ""
    ///确认密码Str
    var confirmPasswordStr: String = ""
    ///验证码Str
    var smCodeStr: String = ""
    
    var nextStepBlock: NextStepClick?
    
    var timeNumber:NSInteger = 60
    var timer:Timer?
    
    override func draw(_ rect: CGRect) {
        UIView.addShadow(shadowColor: Shadow_backGroundColor ,shadowOffset: CGSize.init(width: 0, height: 2), shadowRadius: 3, shadowOpacity: 0.7, cornerRadius: 5, masksToBounds: true, toView: self.contentView)
    }
    
    func startTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        timeNumber = 60
        //创建定时器
        timer = Timer.scheduledTimer(timeInterval: 1, target: YYWeakProxy.init(target: self), selector: #selector(timeCountDown), userInfo: nil, repeats: true)
    }
    
    func timeCountDown() {
        if timeNumber == 0 {
            verificationCodeBtn.isEnabled = true
            self.timer?.invalidate()
            self.timer = nil
            self.verificationCodeBtn.setTitle("获取验证码", for: UIControlState.normal)
            self.verificationCodeBtn.setTitleColor(Gradient_Right_Color, for: .normal)
        }else{
            verificationCodeBtn.isEnabled = false
            timeNumber -= 1
            let sendMessageStr = NSString.init(format: "%02ds", timeNumber)
            self.verificationCodeBtn.setTitle(sendMessageStr as String, for: UIControlState.normal)
            self.verificationCodeBtn.setTitleColor(UIColor.lightGray, for: .normal)
        }
    }

    
    @IBAction func verificationAction(_ sender: UIButton) {
        
        self.endEditing(true)
        
        let mobile = self.accountTextField.text ?? ""
        
        if self.accountTextField.text?.isEmpty == true {
            SVProgressHUD.showError(withStatus: "请先输入手机号")
            return
        }
        
        
        if JYUtilities.verifyPhoneNumber(self.accountTextField.text) == false {
            SVProgressHUD.showError(withStatus: "请输入正确手机号")
            return
        }
        
        let pid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        
        if self.forgetPassword == true {
            let params = ["mobile": mobile, "type": type_forgetPsd, "pid": pid] as NSDictionary
            SmCodeViewModel.requestData(params: params) { [unowned self] in
                self.startTimer()
            }
        }else {
            let params = ["mobile": mobile, "type": type_forgetPsd, "pid": pid] as NSDictionary
            SmCodeViewModel.requestData(params: params) { [unowned self] in
                self.startTimer()
            }
        }
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
         self.endEditing(true)
        
        if self.passwordTextField.text != self.confirPasswordTextField.text {
            SVProgressHUD.showError(withStatus: "两次密码不一致，请重新输入")
            self.confirPasswordBottomLine.backgroundColor = UIColor.red
            
            return
        }
        
        self.registerBtn.isEnabled = false
        self.registerBtn.setTitle("", for: .normal)
        self.indicatorView.startAnimating()
        print("\(self.accountStr) \(self.passwordStr) \(self.confirmPasswordStr) \(self.smCodeStr)")
        
        if self.nextStepBlock != nil {
            self.nextStepBlock!()
        }
    }
    

}

extension RegisterHeaderView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nsString = textField.text as NSString?
        let newString = nsString?.replacingCharacters(in: range, with: string)
        
        switch textField.tag {
        case AccountTF:
            self.accountStr = newString ?? ""
        case PasswordTF:
            self.passwordStr = newString ?? ""
        case ConfirmPasswordTF:
            self.confirmPasswordStr = newString ?? ""
        default:
            self.smCodeStr = newString ?? ""
        }
        
        if self.accountStr.isEmpty || self.passwordStr.isEmpty || self.confirmPasswordStr.isEmpty || self.smCodeStr.isEmpty {
            self.registerBtn.isEnabled = false
        }else {
            self.registerBtn.isEnabled = true
        }
        
        return true
    }
    
}
