//
//  LoginController.swift
//  OrderPay
//
//  Created by answer.zou on 17/11/5.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    lazy var backBtn: UIButton = {
        //设置返回按钮属性
        let backBtn = UIButton(type: UIButtonType.custom)
        backBtn.showsTouchWhenHighlighted = true
        backBtn.isExclusiveTouch = true
        let btnW: CGFloat = ScreenWidth > 375.0 ? 44 : 44
        backBtn.frame = CGRect(x:0, y:0, width:30, height:30)
        backBtn.setImage(UIImage(named: "login_close"), for: .normal)
        backBtn.setImage(UIImage(named: "login_close"), for: .highlighted)
        backBtn.titleLabel?.isHidden = true
        backBtn.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
//        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        
        return backBtn
    }()
    
    fileprivate lazy var loginHeaderView: LoginHeaderView = {
        
        let loginHeaderV = Bundle.main.loadNibNamed("LoginHeaderView", owner: nil, options: nil)?.first as! LoginHeaderView
        
        return loginHeaderV
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .grouped)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false;
        tableView.tableHeaderView = self.loginHeaderView
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        
        self.view.addSubview(self.tableView)
        
        self.addBackBtn()
        
        self.loginHeaderView.loginBtnClick = { [unowned self] (account, password)  in
            
//            print(account, password)
            
            let pid = UIDevice.current.identifierForVendor?.uuidString ?? ""
            let psd = password ?? ""
            let act = account ?? ""
            self.loginHeaderView.loginBtn.isEnabled = false
            self.loginHeaderView.loginBtn.setTitle("", for: .normal)
            self.loginHeaderView.indicatorView.startAnimating()
            
            let params = ["mobile": act, "pwd": psd, "pid": pid] as NSDictionary
            LoginViewModel.requestData(headerView: self.loginHeaderView, params: params , returnBlock: {
                self.dismiss(animated: true, completion: {
                    let rootVC = UIApplication.shared.keyWindow?.rootViewController as! MainTabBarController
                    rootVC.selectedIndex = 0
                })
            })
        }
        
//        self.loginHeaderView.loginBtnClick = { [unowned self] in
//            self.loginHeaderView.loginBtn.isEnabled = false
//            self.loginHeaderView.indicatorView.startAnimating()
//        }
        
        self.loginHeaderView.registerBtnClick = { [unowned self] in
            let registerVC = RegisterController()
            
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
        
        self.loginHeaderView.forgetBtnClick = { [unowned self] in
            let registerVC = RegisterController()
            registerVC.forgetPassword = true
            
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
    }
    
    func shakeToHide(view: UIView) {
        let animation = CABasicAnimation.init(keyPath: "transform.scale")
        animation.duration = 0.1
        animation.repeatCount = 1
        animation.autoreverses = false
        
        animation.fromValue = NSNumber(value: 1)
        animation.toValue = NSNumber(value: 0)
        
        view.layer.add(animation, forKey: nil)
    }
    
    func addBackBtn(){
        
        let leftBtn:UIBarButtonItem = UIBarButtonItem.init(customView: self.backBtn)
        
        self.navigationItem.leftBarButtonItem = leftBtn;
        
    }
    
    //返回按钮事件
    
    func actionBack(){
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

  
}
