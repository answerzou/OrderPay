//
//  RegisterController.swift
//  OrderPay
//
//  Created by answer.zou on 17/11/5.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
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
        
        self.view.addSubview(self.tableView)
        
        self.registerHeaderView.nextStepBlock = {[unowned self] in
            self.tableView.tableHeaderView = self.realNameView
        };

    }


}
