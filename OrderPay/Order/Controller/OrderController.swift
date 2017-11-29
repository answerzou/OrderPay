//
//  OrderController.swift
//  OrderPay
//
//  Created by answer.zou on 17/9/25.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

let BackgroundView_Height = CGFloat(75)

class OrderController: BaseController {
    
    let reuseIdentifier = "OrderCell"
    
    // 顶部刷新
    var header = MJRefreshNormalHeader()
    
    
    fileprivate lazy var topView:UIView = {
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 70))
        return topView
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
    
        
    fileprivate lazy var rightButton: UIButton = {
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 32)
        
        btn.set(image: UIImage(named: "bg_selectCity"), title: "城市", titlePosition: .left,
                additionalSpacing: 10.0, state: UIControlState.normal)
        btn.addTarget(self, action: #selector(selectCity), for: .touchUpInside)
        
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的订单"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.rightButton)
        self.view.addSubview(self.topView)
        self.view.addSubview(self.tableView)
        tableView.register(UINib.init(nibName: "OrderCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        
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

extension OrderController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! OrderCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detail = OrderDetailController()
        self.navigationController?.pushViewController(detail, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }

}


extension OrderController: CityListViewDelegate {
    func didClicked(withCityName cityName: String!) {
//        self.cityCode = JYXML.getCodeFromCity(cityName)!
//        print("xxx\(JYXML.getCodeFromCity(cityName)!)")
//        self.city = cityName
        print(cityName)
        rightButton.set(image: UIImage(named: "bg_selectCity"), title: cityName, titlePosition: .left,
                        additionalSpacing: 10.0, state: UIControlState.normal)
    }
    
    func selectCity() {
        JYCitySelectManager.sharedInstance().show { (cityName) in
            print(cityName ?? "")
            let provinceCode = UserDefaults.standard.object(forKey: "LiveProvinceCode")
            let cityCode = UserDefaults.standard.object(forKey: "LiveCityCode")
            let countyCode = UserDefaults.standard.object(forKey: "LiveCountyCode")
            
            print("\(provinceCode) + \(cityCode) +\(countyCode)")
        }
    
    }
    
}


