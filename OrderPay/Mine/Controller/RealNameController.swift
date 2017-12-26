//
//  RealNameController.swift
//  OrderPay
//
//  Created by MAc on 2017/12/12.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

import UIKit

class RealNameController: UIViewController {
    
    fileprivate lazy var realNameView: RealNameView = {
        
        let realNameV = Bundle.main.loadNibNamed("RealNameView", owner: nil, options: nil)?.first as! RealNameView
        
        return realNameV
        
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: .grouped)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false;
        tableView.tableHeaderView = self.realNameView
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "实名认证"
        self.realNameView.skipBtn.isHidden = true
        self.realNameView.registerBtnBlock = { [unowned self] in
            
            let pid = UIDevice.current.identifierForVendor?.uuidString ?? ""
            let custCode = UserModel.shared.custCode
            let mobile = UserModel.shared.mobile
            let name = self.realNameView.realNameTextField.text
            let cardNo = self.realNameView.idCardTextField.text
            let cityCode = UserDefaults.standard.object(forKey: "LiveCityCode")
            UserModel.shared.cityCode = cityCode as? String ?? ""
            let companyName = self.realNameView.companyNameTextField.text
            let params = ["pid": pid, "custCode": custCode, "mobile": mobile, "name": name, "cardNo": cardNo, "cityCode": cityCode, "companyName": companyName]
            print(params)
            RealNameViewModel.requestData(headerView: self.realNameView, params: params as NSDictionary, returnBlock: {
                //实名认证成功
                SVProgressHUD.showSuccess(withStatus: "实名认证成功")
                self.navigationController?.popToRootViewController(animated: true)
            })
            self.navigationController?.popViewController(animated: true)
        }
        self.view.addSubview(tableView)
    }

}
