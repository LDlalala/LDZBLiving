//
//  LDEmoticonViewCell.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/19.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

class LDEmoticonViewCell: UICollectionViewCell , NibLoadable{
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    var emoticon : LDEmoticon? {
        didSet { // 监听给模型赋值后赋值给控件
           self.iconImageView.image = UIImage(named: emoticon!.emoticonName)
        }
    }
    
    
}
