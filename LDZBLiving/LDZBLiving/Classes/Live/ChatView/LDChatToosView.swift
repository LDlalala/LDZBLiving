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
    
    // 添加切换表情和输入框切换的按钮
    fileprivate lazy var emoticonBtn : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    // 显示表情的view
    fileprivate lazy var emoticonView : LDEmoticonView = LDEmoticonView(frame: CGRect(x: 0, y: 0, width: KScreenW, height: 250))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
}

// MARK:- 添加控件
extension LDChatToosView {
    func setupUI() {
        
        emoticonBtn.setImage(UIImage(named: "chat_btn_emoji"), for: .normal)
        emoticonBtn.setImage(UIImage(named: "chat_btn_keyboard"), for: .selected)
        emoticonBtn.addTarget(self, action: #selector(emoticonBtnClick(_:)), for: .touchUpInside)
        
        inputTextField.rightView = emoticonBtn
        inputTextField.rightViewMode = .always
        inputTextField.allowsEditingTextAttributes = true
        
        
    }
}


// MARK:- 事件处理
extension LDChatToosView {
    // 输入框点击
    @IBAction func textFieldDidEdit(_ sender: UITextField) {
        
    }
    
    // 发送按钮点击
    @IBAction func sendBtnClick(_ sender: UIButton) {
        
        
    }
    
    // 切换表情和输入框切换
    @objc func emoticonBtnClick(_ sender : UIButton) {
        sender.isSelected = !sender.isSelected
        
        // 记录切换之前的光标位置
        let range = inputTextField.selectedTextRange
        
        inputTextField.resignFirstResponder()
        inputTextField.inputView = inputTextField.inputView == nil ? emoticonView : nil
        inputTextField.becomeFirstResponder()
        
        // 重新赋值光标位置
        inputTextField.selectedTextRange = range
    }
}
