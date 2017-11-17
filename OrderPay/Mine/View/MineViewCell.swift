//
//  MineViewCell.swift
//  OrderPay
//
//  Created by answer.zou on 17/11/3.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

class MineViewCell: UITableViewCell {
    
    @IBOutlet weak var seperatorLine: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    fileprivate var cellIconDic: Dictionary<String, NSArray> {
        let dic = ["0": ["tradingRecord_bg", "personalInfo_bg"], "1": ["feedback", "about"]]
        
        return dic as Dictionary
    }
    
    fileprivate var cellTitleDic: Dictionary<String, NSArray> {
        let dic = ["0": ["我的派单", "个人信息"], "1": ["问题反馈", "关于我们"]]
        
        return dic as Dictionary
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellUI(indexPath: IndexPath, tableView: UITableView) {
        let key = indexPath.section
        let index = indexPath.row
        
        let iconNameArray = self.cellIconDic["\(key)"]
        let imageName = iconNameArray?[index] as! String
        
        let titleArray = self.cellTitleDic["\(key)"]
        let title = titleArray?[index] as! String
        
        self.iconImageView.image = UIImage(named: imageName)
        self.descLabel.text = title
        
        if indexPath.row == 1 {
            self.seperatorLine.isHidden = true
        }else {
            self.seperatorLine.isHidden = false
        }

    }
    
}
