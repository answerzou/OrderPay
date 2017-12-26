//
//  MineController.swift
//  OrderPay
//
//  Created by answer.zou on 17/9/25.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

let SectionNum = 2
let RowNum = 2
let HeightForRow = CGFloat(50)
let HeightForHeader = CGFloat(8)
let HeightForFooter = CGFloat(0.1)

class MineController: BaseController {
    
    let reuseIdentifier = "MineViewCell"
    
    // 顶部刷新
    var header = MJRefreshNormalHeader()
    
    fileprivate lazy var backgroundView: UIView = {
        
        let backgroundView = UIView(frame: self.view.bounds)
        let image = UIImageView(image: UIImage(named: "tableView_backView"))
        image.clipsToBounds = true
        backgroundView.backgroundColor = UIColor.colorWithRGB(247, g: 247, b: 249)
        image.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: ScreenHeight - StatusBarHeight - NavigationBarHeight - TabbarHeight)
        backgroundView.addSubview(image)
        return backgroundView
    }()
    
    fileprivate lazy var tempView: UIView = {
        let tempV = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 200))
        tempV.backgroundColor = Gradient_Right_Color
        
        return tempV
    }()
    
    
    fileprivate lazy var mineView: MineView = {
        
        let mineV = Bundle.main.loadNibNamed("MineView", owner: nil, options: nil)?.first as! MineView
        
        return mineV
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - StatusBarHeight - NavigationBarHeight), style: .grouped)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = self.backgroundView
        tableView.tableHeaderView = self.mineView
        //高度
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        
        return tableView
    }()
    
    fileprivate lazy var rightButton: UIButton = {
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        btn.set(image: UIImage(named: "setting"), title: "", titlePosition: .left,
                additionalSpacing: 10.0, state: UIControlState.normal)
        btn.addTarget(self, action: #selector(settingAction), for: .touchUpInside)
        
        return btn
    }()
    
    fileprivate lazy var topView:UIView = {
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 100))
        return topView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我的"
        
        self.view.addSubview(self.tableView)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.rightButton)
        
        tableView.register(UINib.init(nibName: "MineViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        
        self.mineView.cornerMarkClick = { [unowned self] in
            print("2222")
            CMTitleAlertView.show(withTitle: "关注公众号：\"有单客\"，充值立即获取订单", completion: { (selecIndex) in
                print(selecIndex)
            })
        }
        self.header = MJRefreshNormalHeader(refreshingBlock: {
            print("下拉刷新.")
            //结束刷新
            self.tableView.mj_header.endRefreshing()
        })
//        self.tableView.mj_header = self.header
        self.header.lastUpdatedTimeLabel.isHidden = true
        
    }
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        _ = CAGradientLayer.addGradientLayer(left: Gradient_Left_Color, right:Gradient_Right_Color, toView:self.mineView, isnavigationBar: false, removeLayer: nil)
        
    }
    
    func settingAction() {
        
        if UserModel.shared.name == nil || UserModel.shared.name == ""{
            let login = LoginController()
            let nav = BaseNavigationController(rootViewController: login)
            
            self.navigationController?.present(nav, animated: true, completion: nil)
            
            return
        }
        
        let settingVC = SettingController()
        
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    
}

extension MineController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if UserModel.shared.name == nil || UserModel.shared.name == ""{
            let login = LoginController()
            let nav = BaseNavigationController(rootViewController: login)
            
            self.navigationController?.present(nav, animated: true, completion: nil)
            
            tableView.deselectRow(at: indexPath, animated: true)
            
            return
        }
        
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                self.tabBarController?.selectedIndex = 1
            }else {
                
                let name = UserModel.shared.name ?? ""
                
                if name.isEmpty || name == "<null>" {
                    let realName = RealNameController()
                    self.navigationController?.pushViewController(realName, animated: true)
                }else {
                    
                    let userInfo = NameAuthenticationController()
                    self.navigationController?.pushViewController(userInfo, animated: true)
                }
            }
        }else {
            let aboutUs = AboutUsController()
            self.navigationController?.pushViewController(aboutUs, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionNum
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return RowNum
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MineViewCell
        
        cell.cellUI(indexPath: indexPath, tableView: tableView)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HeightForRow
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return HeightForFooter
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HeightForHeader
    }
    
}



