//
//  JYAddressBook.swift
//  NewEasyRepayment
//
//  Created by jy on 2017/9/11.
//  Copyright © 2017年 jieyuechina. All rights reserved.
//  二次封装通讯录
/**
 *使用方法
 addressBookViewModel = JYAddressBook()
 addressBookViewModel?.addViewModelToController(vc: self)
 addressBookViewModel?.appGetAddressBook()
 addressBookViewModel?.addressBookSelectBlock = {(phone,name) in
 JYAPPLog("\(name):\(phone)")
 }
 */

import UIKit
import AddressBookUI
typealias JYAddressBookSelectBlock = ((_ phoneNumber:String,_ name:String)->())
class JYAddressBook: NSObject,ABPeoplePickerNavigationControllerDelegate {
    ///选中的手机号
    fileprivate var phoneNnmber:String?
    ///选中的名字
    fileprivate var phoneName:String?
    ///address Book对象，用来获取电话簿句柄
    fileprivate var addressBook:ABAddressBook?
    ///需要设置通讯录的控制器
    fileprivate var addressConttroller:UIViewController?
    /// 通讯录回调block
    var addressBookSelectBlock:JYAddressBookSelectBlock?
    /// 绑定控制器
    /// - Parameter vc: 需要通讯录的控制器
    func addViewModelToController(vc:UIViewController) {
        self.addressConttroller = vc
    }
    
    //MARK: - 打开通讯录
    func appGetAddressBook(){
        //定义一个错误标记对象，判断是否成功
        var error:Unmanaged<CFError>?
        let addressBookUnmanaged = ABAddressBookCreateWithOptions(nil, &error)
        if addressBookUnmanaged != nil{//用户权限已打开
            
            addressBook = addressBookUnmanaged?.takeRetainedValue()
        }
        
        if addressBook != nil{
            
            //发出授权信息
            let sysAddressBookStatus = ABAddressBookGetAuthorizationStatus()
            if (sysAddressBookStatus == ABAuthorizationStatus.notDetermined) {
                
                //addressBook = extractABAddressBookRef(ABAddressBookCreateWithOptions(nil, &errorRef))
                ABAddressBookRequestAccessWithCompletion(addressBook, { success, error in
                    if success {
                        
                        //打开通讯录
                        self.openAddressBook()
                    }
                    else {
                        UIAlertView(title: "提示", message: "通讯录授权未成功", delegate: nil, cancelButtonTitle: "确定").show()
                    }
                })
            }
            else if (sysAddressBookStatus == ABAuthorizationStatus.denied ||
                sysAddressBookStatus == ABAuthorizationStatus.restricted) {
                
                UIAlertView(title: "提示", message: "请授权通讯录", delegate: nil, cancelButtonTitle: "确定").show()
            }
            else if (sysAddressBookStatus == ABAuthorizationStatus.authorized) {
                
                //打开通讯录
                self.openAddressBook()
            }
            
        }else{ //通讯录权限被关闭
            
            UIAlertView(title: "提示", message: "请在设置中打开通讯录权限", delegate: nil, cancelButtonTitle: "确定").show()
        }
        
    }
    
    ///弹出通讯录
    fileprivate func openAddressBook(){
        let addressBookVC = ABPeoplePickerNavigationController()
        addressBookVC.peoplePickerDelegate = self
        UINavigationBar.appearance().tintColor = UIColor.black
        self.addressConttroller?.present(addressBookVC, animated: true) { () -> Void in
            UINavigationBar.appearance().tintColor = UIColor.white
        }
    }
    
    // 选择某一个联系人的某一个属性时,会执行该方法
    // property选中的属性
    // identifier : 每一个属性都由一个对应标示
    // 如果实现了该方法,那么选中一个联系人的属性时,就会推出控制器.不会进入下一个页面
    func peoplePickerNavigationController(_ peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
        let firstname = ABRecordCopyValue(person, kABPersonFirstNameProperty)?
            .takeRetainedValue() as! String? ?? ""
        let lastname = ABRecordCopyValue(person, kABPersonLastNameProperty)?
            .takeRetainedValue() as! String? ?? ""
        self.phoneName = lastname + firstname
        //获取电话
        var phoneValues:ABMutableMultiValue? =
            ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue()
        if phoneValues != nil {
            //获取手机号
            let value:Unmanaged? = ABMultiValueCopyValueAtIndex(phoneValues, NSString(format: "%d", identifier).integerValue)
            var phone = value?.takeRetainedValue() as? String ?? ""
            phone = phone.replacingOccurrences(of: "-", with: "")
            self.phoneNnmber = phone
            if !CMRegular.isValidateFormat(phone, type: .phone){
                UIAlertView(title: "提示", message: "您选择的不是手机号", delegate: nil, cancelButtonTitle: "确定").show()
                self.phoneNnmber = ""
                self.phoneName = ""
            }
            if self.phoneNnmber == nil{
                
                self.phoneNnmber = ""
                self.phoneName = ""
            }
            phoneValues = nil
            if let addressBookSelectBlock = addressBookSelectBlock{
                addressBookSelectBlock(self.phoneNnmber!,self.phoneName!)
            }
        }
    }
}
