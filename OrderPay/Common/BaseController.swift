//
//  BaseViewController.swift
//  EasyRepayment
//
//  Created by BJJY on 2017/8/24.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

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
        guard !title.isEmpty else {
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
        guard !title.isEmpty else {
            return
        }
//        MobClick.endLogPageView(title)
    }
}

// MARK:- 公共方法
extension BaseController {
    /// 设置右侧文字按钮
    func setRightTitleButtonWithAction(_ title: String ,_ action: Selector) {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    /// 设置右侧图片按钮
    func setRightImageButtonWithAction(_ image: String ,_ action: Selector) {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: image), for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    /// 设置左侧图片按钮
    func setLeftImageButtonWithAction(_ image: String ,_ action: Selector) {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: image), for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
}
