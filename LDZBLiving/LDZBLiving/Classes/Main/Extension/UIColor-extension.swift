//
//  UIColor-extension.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/2.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

extension UIColor{
    
    // 在extentsion中给系统类扩充构造函数,只能构造'便利构造函数'
    convenience init(r : CGFloat , g : CGFloat ,b : CGFloat , alpha : CGFloat = 1.0) {
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    // 便利构造函数
    convenience init?(hex : String , alpha : CGFloat) {
        
        // 1. 判断传进入的字符串是否是符合要求的
        guard hex.characters.count >= 6 else {
            return nil
        }
        
        // 2. 将字母转化为大写
        var tmpHex = hex.uppercased()
        
        // 3. 判断开头是 #/ 0x / ##
        if tmpHex.hasPrefix("#") {
            tmpHex = (tmpHex as NSString).substring(from: 1)
        }
        
        if tmpHex.hasPrefix("0x") || tmpHex.hasPrefix("##")
        {
            tmpHex = (tmpHex as NSString).substring(from: 2)
        }
        
        // 4. 分别取出RGB 使用Scanner
        var range = NSRange(location:0 ,length:2)
        let rHex = (tmpHex as NSString).substring(with: range)
        range.location = 2;
        let gHex = (tmpHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (tmpHex as NSString).substring(with: range)
        
        var r : Int32 = 0 , g : Int32 = 0, b : Int32 = 0
        Scanner(string: rHex).scanInt32(&r)
        Scanner(string: gHex).scanInt32(&g)
        Scanner(string: bHex).scanInt32(&b)
        
        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b), alpha: alpha)
    }
    
    // 随机颜色
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}
