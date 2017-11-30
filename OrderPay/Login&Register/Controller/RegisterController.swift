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
        tableView.tableHeaderView = self.registerHeaderView
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
            
            let params = ["mobile": mobile, "pwd": pwd, "smCode": smCode, "pid": pid] as NSDictionary
            RegisterViewModel.requestData(headerView: self.registerHeaderView, params: params, returnBlock: {
                
                self.tableView.tableHeaderView = self.realNameView
            })
        }

    }


}
