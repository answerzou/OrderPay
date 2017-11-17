//
//  JYContactManager.swift
//  NewEasyRepayment
//
//  Created by mcintosh on 2017/9/26.
//  Copyright © 2017年 jieyuechina. All rights reserved.
//

import UIKit

import Foundation
import AddressBook
import AddressBookUI


class JYContactManager: NSObject {

    var addressBook:ABAddressBook?

    static let instance = JYContactManager() //这个位置使用 static，static修饰的变量会懒加载
    
    func analyzeSysContacts(_ sysContacts:NSArray) -> [[String:AnyObject]] {
        var allContacts:Array = [[String:AnyObject]]()
        
        func analyzeContactProperty(_ contact:ABRecord, property:ABPropertyID) -> [AnyObject]? {
            let propertyValues:ABMultiValue? = ABRecordCopyValue(contact, property)?.takeRetainedValue()
            if propertyValues != nil {
                var values:Array<AnyObject> = Array()
                for i in 0 ..< ABMultiValueGetCount(propertyValues) {
                    let value = ABMultiValueCopyValueAtIndex(propertyValues, i)
                    switch property {
                    // 地址
                    case kABPersonAddressProperty :
                        var valueDictionary:Dictionary = [String:String]()
                        if let addrNSDict = value?.takeRetainedValue() as? NSMutableDictionary{
                            valueDictionary["_Country"] = addrNSDict.value(forKey: kABPersonAddressCountryKey as String) as? String ?? ""
                            valueDictionary["_State"] = addrNSDict.value(forKey: kABPersonAddressStateKey as String) as? String ?? ""
                            valueDictionary["_City"] = addrNSDict.value(forKey: kABPersonAddressCityKey as String) as? String ?? ""
                            valueDictionary["_Street"] = addrNSDict.value(forKey: kABPersonAddressStreetKey as String) as? String ?? ""
                            valueDictionary["_Contrycode"] = addrNSDict.value(forKey: kABPersonAddressCountryCodeKey as String) as? String ?? ""
                            
                            // 地址整理
                            let fullAddress:String = (valueDictionary["_Country"]! == "" ? valueDictionary["_Contrycode"]! : valueDictionary["_Country"]!) + ", " + valueDictionary["_State"]! + ", " + valueDictionary["_City"]! + ", " + valueDictionary["_Street"]!
                            values.append(fullAddress as AnyObject)
                        }
                    // SNS
                    case kABPersonSocialProfileProperty :
                        var valueDictionary:Dictionary = [String:String]()
                        if let snsNSDict = value?.takeRetainedValue() as? NSMutableDictionary{
                            valueDictionary["_Username"] = snsNSDict.value(forKey: kABPersonSocialProfileUsernameKey as String) as? String ?? ""
                            valueDictionary["_URL"] = snsNSDict.value(forKey: kABPersonSocialProfileURLKey as String) as? String ?? ""
                            valueDictionary["_Serves"] = snsNSDict.value(forKey: kABPersonSocialProfileServiceKey as String) as? String ?? ""
                            
                            values.append(valueDictionary as AnyObject)
                        }
                    // IM
                    case kABPersonInstantMessageProperty :
                        var valueDictionary:Dictionary = [String:String]()
                        if let imNSDict = value?.takeRetainedValue() as? NSMutableDictionary{
                            valueDictionary["_Serves"] = imNSDict.value(forKey: kABPersonInstantMessageServiceKey as String) as? String ?? ""
                            valueDictionary["_Username"] = imNSDict.value(forKey: kABPersonInstantMessageUsernameKey as String) as? String ?? ""
                            
                            values.append(valueDictionary as AnyObject)
                        }
                    // Date
                    case kABPersonDateProperty :
                        let date:String? = (value?.takeRetainedValue() as? Date)?.description
                        if date != nil {
                            values.append(date! as AnyObject)
                        }
                    default :
                        if let val = value?.takeRetainedValue() as? String{
                            values.append(val as AnyObject)
                        }
                    }
                }
                return values
            }else{
                return nil
            }
        }
        
        for contact in sysContacts {
            var currentContact:Dictionary = [String:AnyObject]()
            /*
             部分单值属性
             */
            // 姓、姓氏拼音
            let FirstName:String = ABRecordCopyValue(contact as ABRecord!, kABPersonFirstNameProperty)?.takeRetainedValue() as! String? ?? ""
            currentContact["FirstName"] = FirstName as AnyObject?
            currentContact["FirstNamePhonetic"] = ABRecordCopyValue(contact as ABRecord!, kABPersonFirstNamePhoneticProperty)?.takeRetainedValue() as! String? as AnyObject?? ?? "" as AnyObject?
            // 名、名字拼音
            let LastName:String = ABRecordCopyValue(contact as ABRecord!, kABPersonLastNameProperty)?.takeRetainedValue() as! String? ?? ""
            currentContact["LastName"] = LastName as AnyObject?
            currentContact["LirstNamePhonetic"] = ABRecordCopyValue(contact as ABRecord!, kABPersonLastNamePhoneticProperty)?.takeRetainedValue() as! String? as AnyObject?? ?? "" as AnyObject?
            // 昵称
            currentContact["Nikename"] = ABRecordCopyValue(contact as ABRecord!, kABPersonNicknameProperty)?.takeRetainedValue() as! String? as AnyObject?? ?? "" as AnyObject?
            
            // 姓名整理
            currentContact["fullName"] = LastName as String + FirstName as String as AnyObject?
            
            // 公司（组织）
            currentContact["Organization"] = ABRecordCopyValue(contact as ABRecord!, kABPersonOrganizationProperty)?.takeRetainedValue() as! String? as AnyObject?? ?? "" as AnyObject?
            // 职位
            currentContact["JobTitle"] = ABRecordCopyValue(contact as ABRecord!, kABPersonJobTitleProperty)?.takeRetainedValue() as! String? as AnyObject?? ?? "" as AnyObject?
            // 部门
            currentContact["Department"] = ABRecordCopyValue(contact as ABRecord!, kABPersonDepartmentProperty)?.takeRetainedValue() as! String? as AnyObject?? ?? "" as AnyObject?
            // 备注
            currentContact["Note"] = ABRecordCopyValue(contact as ABRecord!, kABPersonNoteProperty)?.takeRetainedValue() as! String? as AnyObject?? ?? "" as AnyObject?
            // 生日（类型转换有问题，不可用）
            //currentContact["Brithday"] = ((ABRecordCopyValue(contact, kABPersonBirthdayProperty)?.takeRetainedValue()) as NSDate).description
            
            /*
             部分多值属性
             */
            // 电话
            if let Phone:[AnyObject] = analyzeContactProperty(contact as ABRecord, property: kABPersonPhoneProperty){
                if Phone.count > 0{
                   currentContact["Phone"] = Phone as AnyObject
                }
            }
            // 地址
            if let Address:[AnyObject] = analyzeContactProperty(contact as ABRecord, property: kABPersonAddressProperty){
                if Address.count > 0{
                    currentContact["Address"] = Address as AnyObject
                }
            }
            // E-mail
            if let Email:[AnyObject] = analyzeContactProperty(contact as ABRecord, property: kABPersonEmailProperty){
                if Email.count > 0 {
                    currentContact["Email"] = Email as AnyObject
                }
            }
            // 纪念日
            if let Date:[AnyObject] = analyzeContactProperty(contact as ABRecord, property: kABPersonDateProperty){
                if Date.count > 0 {
                    currentContact["Date"] = Date as AnyObject
                }
            }
            // URL
            if let URL:[AnyObject] = analyzeContactProperty(contact as ABRecord, property: kABPersonURLProperty){
                if URL.count > 0{
                    currentContact["URL"] = URL as AnyObject
                }
            }
            // SNS
            if let SNS:[AnyObject] = analyzeContactProperty(contact as ABRecord, property: kABPersonSocialProfileProperty){
                if SNS.count > 0{
                    currentContact["SNS"] = SNS as AnyObject
                }
            }
            allContacts.append(currentContact)
        }
        return allContacts
    }
    
    func getSysContacts() -> [[String:AnyObject]]? {

        //    var error:Unmanaged<CFError>?
        getAddressBook()
        
        let sysAddressBookStatus = ABAddressBookGetAuthorizationStatus()
        
        if sysAddressBookStatus == .denied || sysAddressBookStatus == .notDetermined {
            // Need to ask for authorization
            //        var authorizedSingal:dispatch_semaphore_t = dispatch_semaphore_create(0)
            //        var askAuthorization:ABAddressBookRequestAccessCompletionHandler = { success, error in
            //            if success {
            //                ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as NSArray
            //                dispatch_semaphore_signal(authorizedSingal)
            //            }
            //        }
            //        ABAddressBookRequestAccessWithCompletion(addressBook, askAuthorization)
            //        dispatch_semaphore_wait(authorizedSingal, DISPATCH_TIME_FOREVER)
            let sysAddressBookStatus = ABAddressBookGetAuthorizationStatus()
            
            if sysAddressBookStatus == .denied || sysAddressBookStatus == .notDetermined {
                ABAddressBookRequestAccessWithCompletion(JYContactManager.instance.addressBook){isAccess, errorsd in
                    if isAccess
                    {
                        self.getAddressBook()
                        //操作
//                        JYContactManager.saveContanctInfo(self.analyzeSysContacts( ABAddressBookCopyArrayOfAllPeople(JYContactManager.instance.addressBook).takeRetainedValue() as NSArray ) as NSArray)
                    }else{
                        JYAPPLog("------.Denied/.NotDetermined")
                    }
                }
            }
            getAddressBook()
            return nil
        }else{
            let sysContactsArr = ABAddressBookCopyArrayOfAllPeople(JYContactManager.instance.addressBook).takeRetainedValue() as NSArray
            return analyzeSysContacts(sysContactsArr)
        }
        //
        //    if JYCommonObj.instance.addressBook == nil {
        //        return []
        //    }
//        let sysContactsArr = ABAddressBookCopyArrayOfAllPeople(JYContactManager.instance.addressBook).takeRetainedValue() as NSArray
//        return analyzeSysContacts(sysContactsArr)
    }
    
    func getAddressBook() {
        if JYContactManager.instance.addressBook == nil {
            var errorss:Unmanaged<CFError>?
            JYContactManager.instance.addressBook = ABAddressBookCreateWithOptions(nil,&errorss)?.takeRetainedValue()
            ABAddressBookRegisterExternalChangeCallback(JYContactManager.instance.addressBook, {aaa, ccc, context -> Void in
            //操作
//            JYContactManager.saveContanctInfo(self?.analyzeSysContacts( ABAddressBookCopyArrayOfAllPeople(JYContactManager.instance.addressBook).takeRetainedValue() as NSArray ) as NSArray)
            }, nil);
        }
    }   
}
