//
//  RegisterController.swift
//  OrderPay
//
//  Created by answer.zou on 17/11/5.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
    var forgetPassword: Bool = false
    
    fileprivate lazy var registerHeaderView: RegisterHeaderView = {
        
        let loginHeaderV = Bundle.main.loadNibNamed("RegisterHeaderView", owner: nil, options: nil)?.first as! RegisterHeaderView
        
        return loginHeaderV
    }()
    
    fileprivate lazy var realNameView: RealNameView = {
        
        let realNameV = Bundle.main.loadNibNamed("RealNameView", owner: nil, options: nil)?.first as! RealNameView
        
        return realNameV
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .grouped)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false;
        tableView.tableHeaderView = self.realNameView
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "注册"
        
        if self.forgetPassword == true{
            self.title = "忘记密码"
            self.registerHeaderView.forgetPassword = true
        }
        
        self.view.addSubview(self.tableView)
        
        self.registerHeaderView.nextStepBlock = {[unowned self] in
            
            let pwd = self.registerHeaderView.passwordTextField.text ?? ""
            let smCode = self.registerHeaderView.verificationCodeField.text ?? ""
            let mobile = self.registerHeaderView.accountTextField.text ?? ""
            let pid = UIDevice.current.identifierForVendor?.uuidString ?? ""
            let introducer = self.registerHeaderView.inviteCodeTextField.text ?? ""
            
            let params = ["mobile": mobile, "pwd": pwd, "smCode": smCode, "pid": pid, "inviteCode": introducer] as NSDictionary
            RegisterViewModel.requestData(headerView: self.registerHeaderView, params: params, returnBlock: {
                
                self.tableView.tableHeaderView = self.realNameView
                self.title = "实名认证";
            })
        }
        
        self.realNameView.registerBtnBlock = {[unowned self] in
            
            let pid = UIDevice.current.identifierForVendor?.uuidString ?? ""
            let custCode = UserModel.shared.custCode
            let mobile = UserModel.shared.mobile
            let name = UserModel.shared.name
            let cardNo = self.realNameView.idCardTextField.text
            let cityCode = UserDefaults.standard.object(forKey: "LiveCityCode")
            let companyName = self.realNameView.companyNameTextField.text
            let params = ["pid": pid, "custCode": custCode, "mobile": mobile, "name": name, "cardNo": cardNo, "cityCode": cityCode, "companyName": companyName]
            print(params)
            RealNameViewModel.requestData(headerView: self.realNameView, params: params as NSDictionary, returnBlock: {
                //实名认证成功
                self.navigationController?.popToRootViewController(animated: true)
            })
        }
        
        self.realNameView.skipBtnBlock = {[unowned self] in
            self.navigationController?.popToRootViewController(animated: true)
        }

    }


}
