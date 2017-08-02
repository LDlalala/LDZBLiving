//
//  LDHomeViewController.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/2.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

class LDHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
        view.backgroundColor = UIColor.randomColor()
    }

    private func setUpUI(){
       
        let leftIcon = UIImage(named: "home-logo")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:leftIcon, style:.plain, target: nil, action: nil)
        
        let searchBarFrame = CGRect(x: 0, y: 20, width: 200, height: 32)
        let searchBar = UISearchBar(frame: searchBarFrame)
        navigationItem.titleView = searchBar
        searchBar.placeholder = "主播昵称/房间号/链接"
        
        let rightIcon = UIImage(named: "search_btn_follow")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightIcon, style: .plain, target: nil, action: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK:- 事件监听
extension LDHomeViewController{
    @objc fileprivate func leftItemClick(_ tap : UITapGestureRecognizer){
        
    }
}

