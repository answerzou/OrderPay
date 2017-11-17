//
//  BaseViewController.swift
//  EasyRepayment
//
//  Created by BJJY on 2017/8/24.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 友盟统计
        guard let title = title else {
            return
        }
        guard title.characters.count > 0 else {
            return
        }
//        MobClick.beginLogPageView(title)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 友盟统计
        guard let title = title else {
            return
        }
        guard title.characters.count > 0 else {
            return
        }
//        MobClick.endLogPageView(title)
    }

}
