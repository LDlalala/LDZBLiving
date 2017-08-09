//
//  LDBaseModel.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/7.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

class LDBaseModel: NSObject {

    init(dict : [String : Any]) {
        
        super.init()
        
        setValuesForKeys(dict)
        
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
}
