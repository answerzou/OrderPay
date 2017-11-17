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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        UIView.addShadow(shadowColor: Shadow_backGroundColor ,shadowOffset: CGSize.init(width: 0, height: 2), shadowRadius: 3, shadowOpacity: 0.7, cornerRadius: 5, masksToBounds: true, toView: self.contentView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
