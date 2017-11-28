//
//  VisibleController.swift
//  OrderPay
//
//  Created by MAc on 2017/11/28.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    // 获取当前活动的控制器
    public var visibleViewController:UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(vc: self.rootViewController)
    }
    
    public static func getVisibleViewControllerFrom(vc:UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }
}
