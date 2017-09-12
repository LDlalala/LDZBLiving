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
    // 礼物界面
    var giftListView : LDGiftListView = LDGiftListView.loadNibView()
    
    
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        chatToolsView.inputTextField.resignFirstResponder()
        
        UIView.animate(withDuration: 0.25, animations: {
            self.chatToolsView.frame.origin.y = KScreenH
        })
    }
}


// MARK:- 设置UI界面内容
extension RoomViewController {
    fileprivate func setupUI() {
        // 添加底部tabbar
        setupBlurView()
        
        // 添加聊天界面的view
        setupChatToolsView()
        
        // 添加礼物界面
        setupGiftListView()
    }
    
    private func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = bgImageView.bounds
        blurView.autoresizingMask = [.flexibleTopMargin,.flexibleWidth]
        bgImageView.addSubview(blurView)
    }
    
    private func setupChatToolsView(){
        chatToolsView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: 44)
        view.addSubview(chatToolsView)
        
        // 监听键盘弹起,设置chatToolsView的y值
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    // 添加礼物界面
    private func setupGiftListView(){
        giftListView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: 300)
        giftListView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        view.addSubview(giftListView)
       // print("giftListView.frame" + "\(giftListView.frame)")
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
            giftListView.frame.origin.y -= giftListView.frame.height
           // print("giftListView.frame.y" + "\(giftListView.frame.origin.y)")
           // print("点击了礼物")
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
        let duration = nofi.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let keyboardFrame = (nofi.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let inputViewY = keyboardFrame.origin.y - chatToolsView.frame.height
        
        UIView.animate(withDuration: duration , animations: {
            // setAnimationCurve来定义动画加速或减速方式
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            self.chatToolsView.frame.origin.y = inputViewY
        })
    }
}


