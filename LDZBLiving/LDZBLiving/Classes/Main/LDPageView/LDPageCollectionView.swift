//
//  LDPageCollectionView.swift
//  自定义表情键盘
//
//  Created by 李丹 on 17/8/11.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

// 让外界决定有多少个cell和cell的样式
protocol LDPageCollectionViewDataSource : class{
    func numberOfSections(in pageCollectionView: LDPageCollectionView) -> Int;
    func collectionView(_ pageCollectionView: LDPageCollectionView, numberOfItemsInSection section: Int) -> Int;
    func collectionView(_ pageCollectionView: LDPageCollectionView, _ collectionView : UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell;
}

class LDPageCollectionView: UIView {
    
    weak var dataSource : LDPageCollectionViewDataSource?
    
    fileprivate var titleView : LDTitleView!
    fileprivate var titles : [String]
    fileprivate var isTitleInTop : Bool
    fileprivate var layout : LDPageCollectionViewLayout
    fileprivate var style : LDPageStyle
    
    fileprivate var collectionView : UICollectionView!
    fileprivate var pageControl : UIPageControl!
    
    fileprivate var sourceIndexPath : IndexPath = IndexPath(item: 0, section: 0)
    
    
    init(frame: CGRect, titles: [String], isTitleInTop: Bool, layout: LDPageCollectionViewLayout, style : LDPageStyle) {
        self.titles = titles
        self.isTitleInTop = isTitleInTop
        self.layout = layout
        self.style = style
        
        super.init(frame: frame)
        
        
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        // 1 添加分类标题
        let titleY = isTitleInTop ? 0 : bounds.height - style.titleHeight
        let titleFrame = CGRect(x: 0, y: titleY, width: bounds.width, height: style.titleHeight)
        titleView = LDTitleView(titles: titles, frame: titleFrame, style:style)
        addSubview(titleView)
        titleView.backgroundColor = UIColor.red
        titleView.delegate = self
        
        // 2 添加控制点
        let pageControlH : CGFloat = 20
        let pageControlY = isTitleInTop ? bounds.height - pageControlH : bounds.height - pageControlH - style.titleHeight
        let pageControlFrame = CGRect(x: 0, y: pageControlY, width: bounds.width, height: pageControlH)
        pageControl = UIPageControl(frame: pageControlFrame)
        addSubview(pageControl)
        pageControl.numberOfPages = 4
        pageControl.isEnabled = false
        pageControl.backgroundColor = UIColor.orange
        
        // 3 添加表情
        let collectionViewH : CGFloat = bounds.height - style.titleHeight - pageControlH
        let collectionViewY = isTitleInTop ? style.titleHeight : 0
        let collectionViewFrame = CGRect(x: 0, y: collectionViewY, width: bounds.width, height: collectionViewH)
        collectionView = UICollectionView(frame:collectionViewFrame , collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK:- 暴露外界的方法
extension LDPageCollectionView{
    
    func register(cell : AnyClass?, identifier: String) {
        collectionView.register(cell, forCellWithReuseIdentifier: identifier)
    }
    
    func register(nib : UINib, identifier: String){
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
}


// MARK:- 实现数据源方法UICollectionViewDataSource
extension LDPageCollectionView : UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // 如果没有值就默认为0
        return dataSource?.numberOfSections(in: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 如果没有值就默认为0
        let itemCount = dataSource?.collectionView(self, numberOfItemsInSection: section) ?? 0
        
       // pageControl.numberOfPages = (itemCount - 1) / (layout.cols * layout.row) + 1
        
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource!.collectionView(self, collectionView, cellForItemAt: indexPath)
    }
    
}

// MARK:- 实现滚动的代理方法
extension LDPageCollectionView : UICollectionViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollDidEnd()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollDidEnd()
        }
    }
    
    // 滚动结束
    fileprivate func scrollDidEnd(){
        
        let point = CGPoint(x: collectionView!.contentOffset.x + layout.sectionInset.left + 1, y: layout.sectionInset.top + 1)
        // 根据点获取所在的indexPath
        guard let indexPath = collectionView.indexPathForItem(at: point) else {return}
        
        // 如果滑动到了下一组,那么需要重新设置pagecontrol
        if sourceIndexPath.section != indexPath.section {
            let itemCount = dataSource?.collectionView(self, numberOfItemsInSection: indexPath.section) ?? 0
            pageControl.numberOfPages = (itemCount - 1) / (layout.cols * layout.row) + 1
            
            // 调整titleLabel上选中状态
            titleView.setTitleLabel(targetIndex: indexPath.section, progress: 0)
            
            // 重新赋值
            sourceIndexPath = indexPath
        }
        
        pageControl.currentPage = indexPath.item / (layout.cols * layout.row)
    }
    
}

// MARK:- 实现titleView的代理方法
extension LDPageCollectionView : LDTitleViewDelegate {
    func titleView(_ titleView: LDTitleView, targetIndex: Int) {
        // 怎样计算有多少偏移量呢?
        // 我都已经可以得出具体的item在CollectionView中具体在第几组了,那么直接利用CollectionView中滚动到对应的indexpath就好
        let  indexpath = IndexPath(item: 0, section: targetIndex)
        collectionView.scrollToItem(at: indexpath, at: .left, animated: false)
        collectionView.contentOffset.x -= layout.sectionInset.left
        
        scrollDidEnd()
    }
}





