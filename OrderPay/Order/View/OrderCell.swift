//
//  OrderCell.swift
//  OrderPay
//
//  Created by answer.zou on 17/9/26.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var loanMoneyLabel: UIButton!
    
    @IBOutlet weak var timeLocationLabel: UILabel!
    
    @IBOutlet weak var userInfoOneLabel: UILabel!
    
    @IBOutlet weak var userInfoTwoLabel: UILabel!

    @IBOutlet weak var userInfoThreeLabel: UILabel!
    
    @IBOutlet weak var brokerageLabel: UILabel!
    
    @IBOutlet weak var mobileLabel: UILabel!
    
    @IBOutlet weak var timeLocationBottomConstraint: NSLayoutConstraint!
    
    var model: OrderModel {
        set {
            self.userNameLabel.text = newValue.name
            self.timeLocationLabel.text = newValue.createTime
            self.mobileLabel.text = newValue.mobile
        }
        
        get {
            return self.model
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        UIView.addShadow(shadowColor: Shadow_backGroundColor ,shadowOffset: CGSize.init(width: 0, height: 2), shadowRadius: 3, shadowOpacity: 0.7, cornerRadius: 5, masksToBounds: true, toView: self.contentView)
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
