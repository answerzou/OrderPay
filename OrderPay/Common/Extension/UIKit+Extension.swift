//
//  UIKit+Extension.swift
//  NewEasyRepayment
//
//  Created by jy on 2017/9/4.
//  Copyright © 2017年 jieyuechina. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    /// 圆角和阴影效果
    ///
    /// - Parameters:
    ///   - shadowColor: 阴影颜色
    ///   - shadowOffset: 偏移量
    ///   - shadowOpacity:
    ///   - cornerRadius: 圆角
    ///   - shadowRadius:阴影大小
    ///   - masksToBounds: 是否
    ///   - toView: 需要阴影的view
    class func addShadow(shadowColor:UIColor,shadowOffset:CGSize,shadowRadius:CGFloat,shadowOpacity:Float,cornerRadius:CGFloat,masksToBounds:Bool,toView:UIView){
        toView.layer.shadowOpacity = shadowOpacity
        toView.layer.shadowColor = shadowColor.cgColor
        toView.layer.shadowOffset = shadowOffset
        toView.layer.shadowRadius = shadowRadius
        if masksToBounds {
            toView.layer.cornerRadius = cornerRadius
        }
    }
}

    //MARK:-CAGradientLayer渐变色
extension CAGradientLayer{
    /// view添加渐变色
    ///
    /// - Parameters:
    ///   - left: 左边颜色
    ///   - right: 右边颜色
    ///   - removeLayer:移除重复的layer
    /// - Returns: 返回可修改的layer
    class func addGradientLayer(left:UIColor,right:UIColor,toView:UIView,isnavigationBar:Bool,removeLayer:CAGradientLayer?)->CAGradientLayer {
        removeLayer?.removeFromSuperlayer()
        let gradientLayer = CAGradientLayer()
        if isnavigationBar {
            gradientLayer.frame = CGRect.init(x: 0, y: -20, width: ScreenWidth, height: 64)
        }else{
            gradientLayer.frame = toView.bounds
        }
        //设置渐变的主颜色
        gradientLayer.colors = [left.cgColor, right.cgColor]
        gradientLayer.locations = [0.0,1.0]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1.0, y: 0)
        toView.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
}

    //MARK:-UIColor颜色
extension UIColor{
    ///-RGB颜色
    class func colorWithRGB(_ r: CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }

    ///-RGB颜色
    class func colorWithRGBA(_ r: CGFloat, g:CGFloat, b:CGFloat,a:CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    ///-随机色
    class func colorWithRandom() -> UIColor {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return UIColor.colorWithRGB(r, g: g, b: b)
    }
    
    /// ------------- 颜色设置
    class func colorWithHexStrings (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}

extension UIImage{
    ///用layer创建图片
    class func imageFromLayer(layer:CALayer)->UIImage{
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
}
