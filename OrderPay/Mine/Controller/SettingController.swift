//
//  SettingController.swift
//  OrderPay
//
//  Created by answer.zou on 17/11/4.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

class SettingController: UIViewController {
    
    fileprivate lazy var settingView: SettingView = {
        
        let settingV = Bundle.main.loadNibNamed("SettingView", owner: nil, options: nil)?.first as! SettingView
        
        return settingV
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - StatusBarHeight - NavigationBarHeight), style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.tableHeaderView = self.settingView
        return tableView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "设置"
        self.view.addSubview(self.tableView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        _ = UIView.addShadow(shadowColor: Shadow_backGroundColor ,shadowOffset: CGSize.init(width: 0, height: 2), shadowRadius: 3, shadowOpacity: 0.7, cornerRadius: 5, masksToBounds: true, toView: self.settingView.userInfoView)
        
    }


}
