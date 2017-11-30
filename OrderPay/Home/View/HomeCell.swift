//
//  HomeCell.swift
//  OrderPay
//
//  Created by MAc on 2017/11/30.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    
    ///用户姓名
    @IBOutlet weak var usernameLabel: UILabel!
    ///借款金额
    @IBOutlet weak var loanMoneyBtn: UIButton!
    ///申请时间
    @IBOutlet weak var applyTimeLabel: UILabel!
    ///手机号
    @IBOutlet weak var mobileLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        UIView.addShadow(shadowColor: Shadow_backGroundColor ,shadowOffset: CGSize.init(width: 0, height: 2), shadowRadius: 3, shadowOpacity: 0.7, cornerRadius: 5, masksToBounds: true, toView: self.contentView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
