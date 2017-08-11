//
//  KingfisherExtension.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/11.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
   
    func setImage(_ URLString : String? , _ placeHolderName : String?){
        guard let urlStr = URLString else { return}
        
        guard let url = URL(string: urlStr) else {return}
        
        guard let placeholderName = placeHolderName else {return}
        
        kf.setImage(with: url, placeholder: UIImage(named: placeholderName))
    }
    
    
}
