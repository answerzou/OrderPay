//
//  AppMacro.swift
//  NewEasyRepayment
//
//  Created by McIntosh on 2017/8/25.
//  Copyright © 2017年 jieyuechina. All rights reserved.
//

import Foundation
import UIKit
//import SnapKit

// 测试（发版的时候改为false）
let Vendor_DEBUG = true

let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
// app版本号
let infoDic           = Bundle.main.infoDictionary! as NSDictionary
let JYAppVerionNum    = infoDic["CFBundleShortVersionString"] as! String
let appDelegate       = UIApplication.shared.delegate as! AppDelegate
/*** 自定义LOG ***/
func JYAPPLog<T>(_ message:T..., file:String = #file, funcName:String = #function, lineNum:Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("********** 打印信息在 \(fileName) 文件中的 [第\(lineNum)行] **********\n********** 方法名称: \(funcName) **********\n\(message)")
    #endif
}

/*以iPhone6为基准(UI妹纸给你的设计图是iPhone6的),当然你也可以改,但是出图是按照7P(6P)的图片出的,因为大图压缩还是清晰的,小图拉伸就不清晰了,所以只出一套最大的图片即可*/
// 屏幕宽&高
let kScreenW = UIScreen.main.bounds.size.width
let kScreenH = UIScreen.main.bounds.size.height
// W:375 & H:667 是以 iPhone6 为参考
let kIPhone6W: CGFloat = 375.0
let kIPhone6H: CGFloat = 667.0
// 各个屏幕比例
let kScaleX = kScreenH / kIPhone6W
let kScaleY = kScreenH / kIPhone6H
// X&W比例
func kLineX(_ x: CGFloat) -> CGFloat {
    return x*kScaleX
}
// Y&H比例
func kLineY(_ y: CGFloat) -> CGFloat {
    return y*kScaleY
}
// 字体比例
func kFont(_ f: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: f*kScaleX)
}

enum RefreshType{
    case HeaderRefreshType
    case FooterRefreshType
}

// 加密相关
let AESKey          = "abcdnnnnnn123456"
let AESBodyKey      = "0123456789123456"
let AESDecryptKey   = "0123456789123456"
let AESBodyEncrypt  = "aesRequest"//AES加密请求字段
let AESBodyDecrypt  = "aesResponse"//AES解密请求字段
let ResponseBody    = "responseBody"  //返回数据body

//
let KEY_IN_KEYCHAIN_UUID = "com.jieyuechina.NewEasyRepayment.UUID"

//H5需要传入的UserAgent的值
let WKWEBVIEW_CUSTOMUSERAGENT = "iosH5App"


