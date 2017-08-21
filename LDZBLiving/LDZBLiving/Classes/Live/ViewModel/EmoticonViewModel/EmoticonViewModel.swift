//
//  EmoticonViewModel.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/21.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

class EmoticonViewModel {
    
    // 创建单例对象
    static let shareEmoticonModel : EmoticonViewModel = EmoticonViewModel()
    // 组数组
    var packages : [LDEmoticonPackage] = [LDEmoticonPackage]()
    
    init(){
        packages.append(LDEmoticonPackage(plistName : "QHNormalEmotionSort.plist"))
        packages.append(LDEmoticonPackage(plistName : "QHSohuGifSort.plist"))
    }
    
}
