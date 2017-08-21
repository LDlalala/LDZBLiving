//
//  NibLoadable.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/21.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

protocol NibLoadable {
    
}


extension NibLoadable where Self : UIView {
    
   static func loadNibView(_ nibname : String? = nil ) -> Self {
        let loadname = nibname == nil ? "\(self)" : nibname!
        return Bundle.main.loadNibNamed(loadname, owner: nil, options: nil)?.first as! Self
    }
    
}
