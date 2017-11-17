//
//  OrderDetailController.swift
//  OrderPay
//
//  Created by answer.zou on 17/10/17.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

let buttomBtnHeight = CGFloat(50)

class OrderDetailController: BaseController {
    
    ///渐变色
    var navBackLayer:CAGradientLayer?
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - StatusBarHeight - NavigationBarHeight - 30), style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.groupTableViewBackground
        return tableView
    }()
    
    fileprivate var headerView: OrderDetailView {
        let header = Bundle.main.loadNibNamed("OrderDetailView", owner: nil, options: nil)?.last as! OrderDetailView
        return header
    }
    
    fileprivate var buttomBtn: UIButton {
        let btn = UIButton(type: .custom)
        let btnY: CGFloat
        
        if iphoneX == true {
            btnY = ScreenHeight - buttomBtnHeight - NavigationBarHeight - StatusBarHeight - TabbarSafeBottomMargin + 10
        }else {
            btnY = ScreenHeight - buttomBtnHeight - NavigationBarHeight - StatusBarHeight
        }
        btn.frame = CGRect.init(x: 0, y: btnY, width: ScreenWidth, height: buttomBtnHeight)
        btn.setTitle("立即抢单", for: .normal)
        btn.backgroundColor = UIColor.white
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        
//        let navImageView = UIImageView.init(frame: btn.frame)
//        navBackLayer = CAGradientLayer.addGradientLayer(left: Gradient_Left_Color, right: Gradient_Right_Color, toView: navImageView, isnavigationBar: true, removeLayer: navBackLayer)
//        btn.setBackgroundImage(UIImage.imageFromLayer(layer: navBackLayer!), for: .normal)
        btn.setTitleColor(Gradient_Right_Color, for: .normal)
        
        return btn
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单详情"
    
        self.view.addSubview(self.tableView)
        self.tableView.tableHeaderView = self.headerView
        
        self.view.addSubview(self.buttomBtn)
    }
    
}
