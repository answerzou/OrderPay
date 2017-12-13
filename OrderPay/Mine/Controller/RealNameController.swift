//
//  RealNameController.swift
//  OrderPay
//
//  Created by MAc on 2017/12/12.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

class RealNameController: UIViewController {
    
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
        self.realNameView.registerBtnBlock = { [unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
        self.view.addSubview(tableView)
    }

}
