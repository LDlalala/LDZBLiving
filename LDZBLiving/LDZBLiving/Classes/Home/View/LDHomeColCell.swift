//
//  LDHomeColCell.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/9.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

class LDHomeColCell: UICollectionViewCell {

    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var liveImage: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlinePeopleLabel: UIButton!
    
    
    var anchorModel : LDAnchorModel? {
        didSet {
            albumImage.setImage(anchorModel!.isEvenIndex ? anchorModel?.pic74 : anchorModel?.pic51, "home_pic_default")
            liveImage.isHidden = anchorModel?.live == 0
            nickNameLabel.text = anchorModel?.name
            onlinePeopleLabel.setTitle("\(anchorModel?.focus ?? 0)", for: .normal)
            
        }
    }

}
