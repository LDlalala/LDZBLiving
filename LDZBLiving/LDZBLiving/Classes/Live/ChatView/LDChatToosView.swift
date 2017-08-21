//
//  LDChatToosView.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/19.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

class LDChatToosView: UIView , NibLoadable{

    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendMsgBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
}


extension LDChatToosView {
    // 输入框点击
    @IBAction func textFieldDidEdit(_ sender: UITextField) {
        
    }
    
    // 发送按钮点击
    @IBAction func sendBtnClick(_ sender: UIButton) {
        
        
    }
}
