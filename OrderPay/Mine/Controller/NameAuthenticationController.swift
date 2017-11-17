//
//  NameAuthenticationController.swift
//  OrderPay
//
//  Created by answer.zou on 17/11/4.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

class NameAuthenticationController: UIViewController {
    
    fileprivate lazy var nameAuthenticationView: NameAuthenticationView = {
        
        let view = Bundle.main.loadNibNamed("NameAuthenticationView", owner: nil, options: nil)?.first as! NameAuthenticationView
        return view
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - StatusBarHeight - NavigationBarHeight), style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.tableHeaderView = self.nameAuthenticationView
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "个人信息"
        
        self.view.addSubview(self.tableView)
    }

}
