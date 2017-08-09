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
        
        // 添加标题视图
        setupPageView()
        
        automaticallyAdjustsScrollViewInsets = false
        
       // view.backgroundColor = UIColor.white
    }

    private func setUpUI(){
       
        
        let leftIcon = UIImage(named: "home-logo")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:leftIcon, style:.plain, target: nil, action: nil)
        
        let searchBarFrame = CGRect(x: 0, y: KStatusBarH, width: 200, height: 32)
        let searchBar = UISearchBar(frame: searchBarFrame)
        navigationItem.titleView = searchBar
        searchBar.placeholder = "主播昵称/房间号/链接"
        
        let searchField = searchBar.value(forKey: "_searchField") as? UITextField
        searchField?.textColor = UIColor.white
        
        let rightIcon = UIImage(named: "search_btn_follow")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightIcon, style: .plain, target: nil, action: nil)
        
        // 设置导航栏的背景颜色
        navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    private func setupPageView(){
        let homeTypes = loadTitles()
        
        let frame = CGRect(x: 0, y: KNavgationBarH, width: Int(KScreenW), height: Int(view.bounds.height))
        let titles = homeTypes.map { (type : LDHomeType) -> String in
            return type.title
        }
        
        // 另一种写法
       // let titles = homeTypes.map({$0.title})
        
        let style = LDPageStyle()
        style.isScrollEnadle = true
        style.normalColor = UIColor.white
        style.selectColor = UIColor.yellow
        
        var childvcs = [LDAnchorViewController]()
        for type in homeTypes {
            let vc = LDAnchorViewController()
            vc.homeType = type
            childvcs.append(vc)
        }
        // print(childvcs)
        
        let pageView = LDPageView(frame: frame, titles: titles, style: style, childVcs: childvcs, parent: self)
        view.addSubview(pageView)
    }
    
    private func loadTitles() -> [LDHomeType]{
        let path = Bundle.main.path(forResource: "types.plist", ofType: nil)!
        let dataArray = NSArray(contentsOfFile: path) as! [[String: Any]]
        var tmpArray = [LDHomeType]()
        
        for dict in dataArray {
            tmpArray.append(LDHomeType(dict: dict))
        }
        return tmpArray
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

