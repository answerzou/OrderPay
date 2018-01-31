//
//  HomeController.swift
//  OrderPay
//
//  Created by answer.zou on 17/9/25.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

class HomeController: BaseController {
    
    let reuseIdentifier = "HomeCell"
    
    // 顶部刷新
    var header = MJRefreshNormalHeader()
    
    
    fileprivate lazy var topView:UIView = {
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 70))
        return topView
    }()
    
    fileprivate lazy var usernameArray: [String] = {
        let array = ["张先生", "黄先生", "王女士", "邹先生", "王先生", "赵先生", "孙先生", "李先生", "王先生", "黄女士"]
        
        return array
    }()
    
    fileprivate lazy var loanMoneyArray: [String] = {
        let array = ["2万", "2万", "1万", "1.5万", "3万", "5万", "2万", "1万", "2.5万", "3万"]
        
        return array
    }()
    
    fileprivate lazy var mobileArray: [String] = {
        let array = ["185****7765", "183****5131", "133****1357", "185****2032", "188****6480", "176****9219", "158****0134", "186****5477", "133****3501", "173****5067"]
        
        return array
    }()
    
    fileprivate lazy var applyTimeArray: [String] = {
        let array = ["2017-09-24", "2017-09-26", "2017-10-01", "2017-10-05", "2017-10-16", "2017-10-29", "2017-11-02", "2017-11-05", "2017-11-12", "2017-1-21"]
        
        return array
    }()
    
    fileprivate lazy var userAgeArray: [String] = {
        let array = ["23", "30", "28", "32", "35", "22", "33", "30", "29", "20"]
        
        return array
    }()
    
    fileprivate lazy var maritalStatus: [String] = {
        let array = ["未婚", "已婚", "未婚", "已婚", "已婚", "未婚", "已婚", "未婚", "已婚", "未婚"]
        
        return array
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - StatusBarHeight - NavigationBarHeight), style: .plain)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        //        tableView.backgroundView = self.backgroundView
        tableView.backgroundColor = .clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        self.tabBarController?.delegate = self
        
        self.view.addSubview(self.topView)
        self.view.addSubview(self.tableView)
        tableView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        
        self.header = MJRefreshNormalHeader(refreshingBlock: {
            print("下拉刷新.")
            //结束刷新
            self.tableView.mj_header.endRefreshing()
        })
        self.tableView.mj_header = self.header
        self.header.lastUpdatedTimeLabel.isHidden = true
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            print("上拉刷新")
            self.tableView.mj_footer.endRefreshing()
        })
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        _ = CAGradientLayer.addGradientLayer(left: Gradient_Left_Color, right:Gradient_Right_Color, toView:self.topView, isnavigationBar: false, removeLayer: nil)
    }

}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! HomeCell
        cell.usernameLabel.text = self.usernameArray[indexPath.row]
//        cell.loanMoneyBtn.setTitle(self.loanMoneyArray[indexPath.row], for: .normal)
        cell.mobileLabel.text = self.mobileArray[indexPath.row]
        cell.applyTimeLabel.text = self.applyTimeArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detail = OrderDetailController()
        let homeModel = HomeModel()
        homeModel.userName = self.usernameArray[indexPath.row]
        homeModel.loanMoney = self.loanMoneyArray[indexPath.row]
        homeModel.applyTime = self.applyTimeArray[indexPath.row]
        homeModel.userAge = self.userAgeArray[indexPath.row]
        homeModel.maritalStatus = self.maritalStatus[indexPath.row]
        
        detail.homeModel = homeModel
        self.navigationController?.pushViewController(detail, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }
    
}


extension HomeController: UITabBarControllerDelegate {
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        
//        if tabBarController.viewControllers?.index(of: viewController) == 1 {
//            
//            if UserModel.shared.name == nil || UserModel.shared.name == ""{
//                let login = LoginController()
//                let nav = BaseNavigationController(rootViewController: login)
//                
//                self.navigationController?.present(nav, animated: true, completion: nil)
//                
//                return false
//            }else {
//                return true
//            }
//        }else {
//            return true
//        }
//    }
}
