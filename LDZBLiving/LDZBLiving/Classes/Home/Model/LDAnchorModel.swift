//
//  LDAnchorModel.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/9.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

class LDAnchorModel: LDBaseModel {
    var roomid : Int = 0
    var name : String = ""
    var pic51 : String = ""
    var pic74 : String = ""
    var live : Int = 0 // 是否在直播
    var push : Int = 0 // 直播显示方式
    var focus : Int = 0 // 关注数
    
    var isEvenIndex : Bool = false
}
