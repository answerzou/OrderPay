//
//  GlobalMacro.swift
//  NewEasyRepayment
//
//  Created by jy on 2017/9/4.
//  Copyright © 2017年 jieyuechina. All rights reserved.
//

import Foundation
import UIKit

//MARK:-我的

let Gradient_Left_Color = UIColor.colorWithHexStrings("1A71FF")   //渐变蓝色左
let Gradient_Right_Color = UIColor.colorWithHexStrings("1299F9")
let Gradient_Left_YellowColor = UIColor.colorWithHexStrings("fec101")   //渐变黄色左
let Gradient_Right_YellowColor = UIColor.colorWithHexStrings("ffb001")
let TableView_backGroundColor = UIColor.colorWithHexStrings("F7F7F9")  //TableView背景色

let Shadow_backGroundColor = UIColor.colorWithHexStrings("D7D7D7")  //shadow背景色
let YellowColor_TextColor = UIColor.colorWithHexStrings("8d5000")  //黄色字体


let JYIOSVersion      = UIDevice.current.systemVersion//ios版本
// UUID 设备唯一标识符
let JYDeviceUUID      = UIDevice.current.identifierForVendor!.uuidString//设备uuid
let JYSystemName      = UIDevice.current.systemName//设备名称
let JYModel           = UIDevice.current.model//设备型号
///是否需要手势解锁标识符
let JYGestureIdentifier = "JYMineModifyGestureIdentifier"
