//
//  OrderController.swift
//  OrderPay
//
//  Created by answer.zou on 17/9/25.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

let BackgroundView_Height = CGFloat(75)
let PageSize = 10
let PlaceHolderHintViewTag = 999

class OrderController: BaseController {
    
    let reuseIdentifier = "OrderCell"
    
    //页码
    var page: NSInteger = 1
    
    // 顶部刷新
    var header = MJRefreshNormalHeader()
    
    //是否显示svhud
    var hideSV: Bool = false
    
    
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
    
    fileprivate lazy var dataArray: NSMutableArray = {
        let dataArr = NSMutableArray.init(capacity: 0)
        
        return dataArr
    }()
    
        
    fileprivate lazy var rightButton: UIButton = {
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 32)
        
        btn.set(image: UIImage(named: "bg_selectCity"), title: "城市", titlePosition: .left,
                additionalSpacing: 10.0, state: UIControlState.normal)
        btn.addTarget(self, action: #selector(selectCity), for: .touchUpInside)
        
        return btn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideSV = true
        self.tableView.mj_header.beginRefreshing()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "派单"
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.rightButton)
        self.view.addSubview(self.topView)
        self.view.addSubview(self.tableView)
        tableView.register(UINib.init(nibName: "OrderCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        
        self.header = MJRefreshNormalHeader(refreshingBlock: {
            print("下拉刷新.")
            self.hideSV = false
            self.page = 1
            self.requestData(type: self.tableView.mj_header)
            
        })
        self.tableView.mj_header = self.header
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            print("上拉刷新")
            self.hideSV = false
            self.page += 1
            
            self.requestData(type: self.tableView.mj_footer)
        })
        self.tableView.mj_footer.isHidden = true
        self.header.lastUpdatedTimeLabel.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        _ = CAGradientLayer.addGradientLayer(left: Gradient_Left_Color, right:Gradient_Right_Color, toView:self.topView, isnavigationBar: false, removeLayer: nil)
    }
    
}

extension OrderController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! OrderCell
        let model = self.dataArray[indexPath.row]
        cell.model = model as! OrderModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //如果没有实名认证则跳转到实名认证
        if UserModel.shared.cardNo?.isEmpty == true {
            
            let realName = RealNameController()
            self.navigationController?.pushViewController(realName, animated: true)
            
            return
        }
        
        let model = self.dataArray[indexPath.row] as! OrderModel
        
        let mobileStr: String = "tel:\(model.mobile ?? "")"
        if mobileStr.count > 0 {
            UIApplication.shared.openURL(URL.init(string: mobileStr)!)
        }
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

extension OrderController {
    func requestData(type: MJRefreshComponent) {
        let pid = UserModel.shared.pid ?? ""
        let mobile = UserModel.shared.mobile ?? ""
        let curPage = self.page
        print(self.page)
        let custCode = UserModel.shared.custCode ?? ""
        let params = ["pid": pid, "mobile": mobile, "curPage": curPage, "custCode": custCode] as [String : Any]
        print(params)
        
        if self.hideSV == false {
            SVProgressHUD.show()
        }
        
        OrderViewModel.requestData(params: params as NSDictionary) { [unowned self] (resultModelArray, requestStatu, totalRows) in
            print(resultModelArray)
            print(requestStatu)
            SVProgressHUD.dismiss()
            if requestStatu == true {
                if self.page == 1 {
                    self.dataArray .removeAllObjects()
                    self.dataArray.addObjects(from: resultModelArray as! [Any])
                    
                }else {
                    if resultModelArray.count > 0 {
                        self.dataArray.addObjects(from: resultModelArray as! [Any])
                    }
                }
                
                //没有数据展示占位图
                if self.dataArray.count == 0 {
                    
                    //保证只有一个占位图放在view上
                    if (self.view.viewWithTag(PlaceHolderHintViewTag) == nil) {
                        self.hideSV = false
                        CMDefaultInfoViewTool.showNoDataView(self.view, action: {
                            self.requestData(type: self.tableView.mj_header)
                            self.tableView.mj_footer.resetNoMoreData()
                        })
                        
                    }
                    
                }else {
                    CMDefaultInfoViewTool.dismiss(from: self.view)
                    self.tableView.mj_footer.isHidden = false
                }
                
                self.tableView.reloadData()
                
                //结束刷新
                if type.isKind(of: MJRefreshHeader.self) {
                    
                    type.endRefreshing()
                }else {
                    if self.dataArray.count == totalRows {
                        self.tableView.mj_footer.endRefreshingWithNoMoreData()
                    }else {
                        self.tableView.mj_footer.endRefreshing()
                    }
                }
                
            }else {
                
                
                //保证只有一个占位图放在view上
                if (self.view.viewWithTag(PlaceHolderHintViewTag) == nil) {
                    self.hideSV = false
                    CMDefaultInfoViewTool.showNoNetView(self.view, action: {
                        self.requestData(type: self.tableView.mj_header)
                        self.tableView.mj_footer.resetNoMoreData()
                    })
                    
                }
            }
            
        }
        
    }
}


