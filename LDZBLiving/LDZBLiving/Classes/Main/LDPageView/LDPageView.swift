//
//  LDPageView.swift
//  LDPageView
//
//  Created by 李丹 on 17/8/2.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

class LDPageView: UIView {

    private var titles : [String]
    private var childVcs : [UIViewController]
    private var parent : UIViewController
    private var style : LDPageStyle
    
    init(frame : CGRect ,titles : [String] ,style : LDPageStyle , childVcs : [UIViewController], parent : UIViewController) {
        // 在super前初始化变量
        assert(titles.count == childVcs.count,"标题&控制器个数不相同,请检测")
        self.titles = titles
        self.childVcs = childVcs;
        self.parent = parent
        self.style = style
        self.parent.automaticallyAdjustsScrollViewInsets = false
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        // 添加标题视图
        let titleFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: style.titleHeight)
        let titleView = LDTitleView(titles: titles, frame: titleFrame, style: style)
        titleView.backgroundColor = UIColor.black
        addSubview(titleView)
        
        
        // 添加内容视图
        let contentFrame = CGRect(x: 0, y: style.titleHeight, width: self.bounds.width, height: self.bounds.height - style.titleHeight)
        let contentView = LDContentView(frame: contentFrame, childVcs: childVcs, parent: parent)
        contentView.backgroundColor = UIColor.randomColor()
        addSubview(contentView)
        
        // 设置contentView&titleView关系
        titleView.delegate = contentView
        contentView.delegate = titleView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
