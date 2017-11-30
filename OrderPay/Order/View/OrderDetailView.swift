//
//  OrderDetailView.swift
//  OrderPay
//
//  Created by answer.zou on 17/10/17.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

class OrderDetailView: UIView {
    
    ///用户年龄
    @IBOutlet weak var userAgeLabel: UILabel!
    ///用户姓名
    @IBOutlet weak var userNameLabel: UILabel!
    ///申请时间
    @IBOutlet weak var applyTimeLabel: UILabel!
    ///借款金额
    @IBOutlet weak var loanMoneyLabel: UILabel!
    ///婚姻状况
    @IBOutlet weak var maritalStatusLabel: UILabel!
    ///薪水
    @IBOutlet weak var salaryLabel: UILabel!
    
    ///头像
    @IBOutlet weak var headImgeView: UIImageView!
    
    
    var tempModel: HomeModel?
    
    var homeModel: HomeModel? {
        didSet {
            self.userAgeLabel.text = homeModel?.userAge
            self.userNameLabel.text = homeModel?.userName
            self.applyTimeLabel.text = homeModel?.applyTime
            self.loanMoneyLabel.text = homeModel?.loanMoney
            self.maritalStatusLabel.text = homeModel?.maritalStatus
            
            let startIndex = homeModel?.userName?.index((homeModel?.userName?.startIndex)!, offsetBy:1)
            let endIndex = homeModel?.userName?.index(startIndex!, offsetBy:2)
            let sex = homeModel?.userName?.substring(with: startIndex..<endIndex)
            
            if sex == "女士" {
                self.headImgeView.image = UIImage.init(named: "orderDetail_female")
            }else {
                self.headImgeView.image = UIImage.init(named: "orderDetail_male")
            }
        }
        
    }
}
