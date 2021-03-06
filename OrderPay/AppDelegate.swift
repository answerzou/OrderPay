//
//  AppDelegate.swift
//  OrderPay
//
//  Created by answer.zou on 17/9/25.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

let iphoneX = (ScreenWidth == 375 && ScreenHeight == 812) ? true : false
let StatusBarHeight = (iphoneX ? CGFloat(44) : CGFloat(20))
let NavigationBarHeight = CGFloat(44)
let TabbarHeight = (iphoneX ? (CGFloat(49) + CGFloat(34)) : CGFloat(49))
let TabbarSafeBottomMargin = (iphoneX ? CGFloat(34) : CGFloat(0))

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        ///友盟统计
        UMengManager.initUmengInfo()
    
        sleep(1)
        UIApplication.shared.statusBarStyle = .lightContent
         UserModel.shared.pid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        NotificationCenter.default.addObserver(self, selector: #selector(saveContance), name: NSNotification.Name(rawValue: "SAVECONTANCT"), object: nil)
        
        //定位
        JYLocationManage.sharedInstance().requestLocation()
        
        window?.rootViewController = MainTabBarController()
        setAppSubject()
        
        if #available(iOS 9.0, *) {
            createShortcutItem()
        } else {
            // Fallback on earlier versions
        }
        
        return true
    }
    
    func saveContance() {
        print("1111");
        
        if let booksArr:NSMutableArray = AddressBookTools.getAddressBook(){
            
            print(booksArr)
            if booksArr.count > 0{
                JYContactManager.saveContanctInfo(booksArr)
            }
        }
}
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        if shortcutItem.type == "myorder" {
            print("我的订单")
            
            //系统自带分享
            let rootVC = UIApplication.shared.keyWindow?.rootViewController as! MainTabBarController
            rootVC.selectedIndex = 1
            
            let nav = rootVC.viewControllers?.first as! BaseNavigationController
            nav.popToRootViewController(animated: true)
            UIApplication.shared.keyWindow?.rootViewController = rootVC

        }else if shortcutItem.type == "roborder" {
            print("我的抢单")
            let rootVC = UIApplication.shared.keyWindow?.rootViewController as! MainTabBarController
            rootVC.selectedIndex = 0
            let nav = rootVC.viewControllers?.first as! BaseNavigationController
            nav.popToRootViewController(animated: true)
            UIApplication.shared.keyWindow?.rootViewController = rootVC
        }
            completionHandler(false)
       
    }
    
    @available(iOS 9.0, *)
    func createShortcutItem() {
        //创建系统风格的icon
        let icon_myorder = UIApplicationShortcutIcon.init(templateImageName: "my-order")
        let icon_roborder = UIApplicationShortcutIcon.init(templateImageName: "rob-order")
        
        //创建快捷选项
        let item_myorder = UIApplicationShortcutItem.init(type: "myorder", localizedTitle: "派单", localizedSubtitle: nil, icon: icon_myorder, userInfo: nil)
        let item_roborder = UIApplicationShortcutItem.init(type: "roborder", localizedTitle: "首页", localizedSubtitle: nil, icon: icon_roborder, userInfo: nil)
        
        UIApplication.shared.shortcutItems = [item_myorder, item_roborder]
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            //版本验证
            JYCommonObj.instance.appVersionCheck()
            
        })
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }


}

extension AppDelegate {
    // MARK:主题设置
    
    func setAppSubject() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        let navBarnAppearance = UINavigationBar.appearance()
        navBarnAppearance.shadowImage = UIImage.init()
        //标题颜色
        let dict:NSDictionary = [NSForegroundColorAttributeName: UIColor.white,NSFontAttributeName : UIFont.boldSystemFont(ofSize: 18)]
        navBarnAppearance.titleTextAttributes = dict as? [String : Any]
        
        navBarnAppearance.isTranslucent = false
    }
    
    func createImage(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? nil
    }
    
}

//／微信支付
extension AppDelegate: WXApiDelegate {
    func onReq(_ req: BaseReq!) {
        
    }
    
    func onResp(_ resp: BaseResp!) {
        
    }
}

extension AppDelegate {
    
    //登出app
    func logoutApp() {
        
        //删除用户信息
        UserModel.shared.clearUserInfo()
        let tab: UITabBarController? = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController
        let nav: UINavigationController? = tab?.selectedViewController as? UINavigationController
        nav?.popToRootViewController(animated: false)
        tab?.selectedIndex = 0
       
    }
}


