//
//  MainTabBarController.swift
//  EasyRepayment
//
//  Created by BJJY on 2017/8/24.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    var indexFlag: NSInteger?
    
    lazy var tabbarButtonArray: NSMutableArray = {
        
        let arrayM = NSMutableArray(capacity: 0)
        
        return arrayM
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpTabBarItemTextAttributes()

        self.buildMainTabBarChildViewController()
        
    }
    
    
    private func buildMainTabBarChildViewController() {

        tabBarControllerAddChildViewController(childView: HomeController(), title: "首页", imageName: "tab_jkcg", selectedImageName: "tab_jkdj")
        
        tabBarControllerAddChildViewController(childView: OrderController(), title: "派单", imageName: "tab_zdcg", selectedImageName: "tab_zddj")
        
        tabBarControllerAddChildViewController(childView: MineController(), title: "我的", imageName: "tab_wdcg", selectedImageName: "tab_wddj")
    }
    
    private func tabBarControllerAddChildViewController(childView: UIViewController, title: String, imageName: String, selectedImageName: String) {
        let vcItem = UITabBarItem(title: title, image: UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal))

        childView.tabBarItem = vcItem
        
        let navigationVC = BaseNavigationController(rootViewController:childView)
        
        addChildViewController(navigationVC)
        
    }
    
    func setUpTabBarItemTextAttributes() {
        let normalAttrs = NSMutableDictionary()
        normalAttrs[NSForegroundColorAttributeName] = UIColor.gray
        
        let selectedAttrs = NSMutableDictionary()
        selectedAttrs[NSForegroundColorAttributeName] = UIColor.yellow
        
//        let tabBarItem = UITabBarItem.appearance()
//        tabBarItem.setTitleTextAttributes(normalAttrs as? [String : Any], for: .normal)
        
        tabBarItem.setTitleTextAttributes(selectedAttrs as? [String : Any], for: .selected)
    }
    
}

extension MainTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let  index = self.tabBar.items?.index(of: item)
        
        if self.indexFlag != index {
            self.animationWithIndex(index: index!)
        }
        
}
    
    func animationWithIndex(index: NSInteger) {
        for tabbarButton in self.tabBar.subviews {
            if tabbarButton.isKind(of: NSClassFromString("UITabBarButton")!) {
//                JYAPPLog("====\(tabbarButton)")
                self.tabbarButtonArray.add(tabbarButton)
            }
        }
        
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulse.duration = 0.1
        pulse.repeatCount = 1
        pulse.autoreverses = true
        pulse.fromValue = NSNumber(value: 0.7)
        pulse.toValue = NSNumber(value: 1.3)
        
        /*
         如果需要对图片添加动画,寻找"UITabBarSwappableImageView"类型的图片子控件;
         如果需要对按钮下面的文字添加动画,寻找"UITabBarButtonLabel"类型的文字子控件即可
         */
        
        //(1)图片动文字不动
        
        let tabbarButton = self.tabbarButtonArray[index] as! UIView
        for imageView in  tabbarButton.subviews{
            if imageView.isKind(of: NSClassFromString("UITabBarSwappableImageView")!) {
                imageView.layer.add(pulse, forKey: nil)
            }
        }
        
        //(2)文字图片一起动
//        let layer = (tabbarButtonArray[index] as! UIView).layer
//        layer.add(pulse, forKey: nil)
        
        self.indexFlag = index
    }
    
}

