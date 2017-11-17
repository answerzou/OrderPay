//
//  BaseNavigationController.swift
//  EasyRepayment
//
//  Created by BJJY on 2017/8/24.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

import UIKit

let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

class BaseNavigationController: UINavigationController {
    ///渐变导航
    var navBackLayer:CAGradientLayer?
    ///隐藏渐变导航
    var hiddenNavBackLayer:Bool = false {
        didSet{
            self.navBackLayer?.isHidden = hiddenNavBackLayer
        }
    }
   lazy var backBtn: UIButton = {
        //设置返回按钮属性
    let backBtn = UIButton(type: UIButtonType.custom)
    backBtn.showsTouchWhenHighlighted = true
    backBtn.isExclusiveTouch = true
    let btnW: CGFloat = ScreenWidth > 375.0 ? 50 : 44
    backBtn.frame = CGRect(x:0, y:0, width:btnW, height:40)
    backBtn.setImage(UIImage(named: "goback"), for: .normal)
    backBtn.setImage(UIImage(named: "goback"), for: .highlighted)
    backBtn.titleLabel?.isHidden = true
    backBtn.addTarget(self, action: #selector(BaseNavigationController.backBtnClick), for: .touchUpInside)
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
    
    return backBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar = UINavigationBar.appearance()
//        navBar.barTintColor = UIColor.white
        navBar.tintColor = UIColor.white
        
        ///导航添加渐变色
        let navImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height: 64))
        navBackLayer = CAGradientLayer.addGradientLayer(left: Gradient_Left_Color, right: Gradient_Right_Color, toView: navImageView, isnavigationBar: true, removeLayer: navBackLayer)
        self.navigationBar.setBackgroundImage(UIImage.imageFromLayer(layer: navBackLayer!), for: .default)
        self.interactivePopGestureRecognizer?.delegate = self
        self.navigationBar.isTranslucent = true
        self.interactivePopGestureRecognizer?.isEnabled = true
}
    
    func backBtnClick() {
        popViewController(animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
}

// MARK:- UIGestureRecognizerDelegate
extension BaseNavigationController: UIGestureRecognizerDelegate {
    
   override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            
            UINavigationBar.appearance().backItem?.hidesBackButton = true
            let leftB = UIBarButtonItem.init(customView: self.backBtn)
            viewController.navigationItem.leftBarButtonItem = leftB
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return childViewControllers.count > 1
    }
    
    /// 暂时不用
    func allScreenGoBack() {
        // 1.取出手势&view
        guard let gesture = interactivePopGestureRecognizer else { return }
        gesture.isEnabled = false
        let gestureView = gesture.view
        // 2.获取所有的target
        let target = (gesture.value(forKey: "_targets") as? [NSObject])?.first
        guard let transition = target?.value(forKey: "_target") else { return }
        let action = Selector(("handleNavigationTransition:"))
        // 3.创建新的手势
        let popGes = UIPanGestureRecognizer()
        popGes.maximumNumberOfTouches = 1
        gestureView?.addGestureRecognizer(popGes)
        popGes.addTarget(transition, action: action)
    }

}
