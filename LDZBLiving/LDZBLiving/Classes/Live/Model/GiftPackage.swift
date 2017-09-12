//
//  GiftPackage.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/21.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

class GiftPackage: LDBaseModel {
    
    var t = 0
    var title = ""
    var list : [GiftModel] = [GiftModel]()
    
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "list" {
            if let listArray = value as? [[String : Any]] {
            
                for listDict in listArray{
                    list.append(GiftModel(dict: listDict))
                }
            }
        }else
        {
            super.setValue(value, forKey: key)
        }
        
    }
    
    
}
