//
//  LiveViewController.swift
//  XMGTV
//
//  Created by apple on 16/11/9.
//  Copyright © 2016年 coderwhy. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController ,Emitterable{
    // Emitterable
    // MARK: 控件属性
    @IBOutlet weak var bgImageView: UIImageView!
    
    // 输入框view添加
    var chatToolsView : LDChatToosView = LDChatToosView.loadNibView()
    
    
    // MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}


// MARK:- 设置UI界面内容
extension RoomViewController {
    fileprivate func setupUI() {
        // 添加底部tabbar
        setupBlurView()
        
        // 添加聊天界面的view
        setupChatToolsView()
    }
    
    private func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = bgImageView.bounds
        bgImageView.addSubview(blurView)
    }
    
    private func setupChatToolsView(){
        let frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: 44)
        chatToolsView = LDChatToosView.init(frame: frame)
        view.addSubview(chatToolsView)
        
        // 监听键盘弹起,设置chatToolsView的y值
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
}


// MARK:- 事件监听
extension RoomViewController {
    @IBAction func exitBtnClick() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bottomMenuClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            chatToolsView.inputTextField.becomeFirstResponder()
           // print("点击了聊天")
           // 弹出键盘
           // 监听键盘弹起,设置chatToolsView的y值
            
        case 1:
            print("点击了分享")
        case 2:
            print("点击了礼物")
        case 3:
            print("点击了更多")
        case 4:
            sender.isSelected = !sender.isSelected
            let point = CGPoint(x: sender.center.x, y: view.bounds.height - sender.bounds.height * 0.5)
            sender.isSelected ? startEmittering(point) : stopEmittering()
        default:
            fatalError("未处理按钮")
        }
    }
    
    // 监听键盘弹起时改变frame
    @objc fileprivate func keyboardWillChangeFrame(_ nofi : Notification){
        print(nofi)
        let duration = nofi.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let keyboardH = nofi.userInfo?[UIKeyboardFrameEndUserInfoKey] as! CGFloat
        
        UIView.animate(withDuration: duration , animations: {
            self.chatToolsView.frame.origin.y -= (keyboardH + self.chatToolsView.frame.height)
        })
    }
}


