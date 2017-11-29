//
//  HomeController.swift
//  OrderPay
//
//  Created by answer.zou on 17/9/25.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

class HomeController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
        
    }

    

}


extension HomeController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if tabBarController.viewControllers?.index(of: viewController) == 1 {
            
            if UserModel.shared.name == nil || UserModel.shared.name == ""{
                let login = LoginController()
                let nav = BaseNavigationController(rootViewController: login)
                
                self.navigationController?.present(nav, animated: true, completion: nil)
                
                return false
            }else {
                return true
            }
        }else {
            return true
        }
    }
}
