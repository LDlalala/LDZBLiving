//
//  LDEmoticonPackage.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/19.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

class LDEmoticonPackage: NSObject {

    var emoticons : [LDEmoticon] = [LDEmoticon]()
    
    init(plistName : String) {
        guard let path = Bundle.main.path(forResource: plistName, ofType: nil) else {
            return
        }
        
        guard let emoticonArrays = NSArray(contentsOfFile: path) else {
            return
        }
        
        for str in emoticonArrays {
            
            emoticons.append(LDEmoticon(emoticonName : str as! String))
        }
    }
    
}
