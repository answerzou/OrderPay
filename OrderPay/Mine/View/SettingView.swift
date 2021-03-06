//
//  SettingView.swift
//  OrderPay
//
//  Created by answer.zou on 17/11/4.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

let logout = 1

class SettingView: UIView {

    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var approveBtn: UIButton!
    
    @IBAction func logoutBtnAction(_ sender: UIButton) {
        
        CMTitleAlertView.show(withTitle: "您确定退出吗？", completion: { (selecIndex) in
            print(selecIndex)
            if selecIndex == logout {
                
                //清空数据
                UserModel.shared.clearUserInfo()
                
                self.viewController().navigationController?.popViewController(animated: true)
            }
        })
        
        
    }
    override func draw(_ rect: CGRect) {
        UIView.addShadow(shadowColor: Shadow_backGroundColor ,shadowOffset: CGSize.init(width: 0, height: 2), shadowRadius: 3, shadowOpacity: 0.7, cornerRadius: 5, masksToBounds: true, toView: self.userInfoView)
    }
    
    func viewController () -> (UIViewController){

        
        //1.通过响应者链关系，取得此视图的下一个响应者
        var next:UIResponder?
        next = self.next!
        repeat {
            //2.判断响应者对象是否是视图控制器类型
            if ((next as?UIViewController) != nil) {
                return (next as! UIViewController)
                
            }else {
                next = next?.next
            }
            
        } while next != nil
        
        return UIViewController()
    }
}
