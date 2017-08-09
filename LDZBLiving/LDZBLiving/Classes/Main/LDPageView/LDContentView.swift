//
//  LDContentView.swift
//  LDPageView
//
//  Created by 李丹 on 17/8/2.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

private let cellID : String = "cellID"

protocol LDContentViewDelegate : class {
    func contentView(_ contentView : LDContentView, targetIndex : Int, progress : CGFloat)
    
}

class LDContentView: UIView {
    
    weak var delegate : LDContentViewDelegate?
    
    fileprivate var childVcs : [UIViewController] = [UIViewController]()
    fileprivate var parent : UIViewController = UIViewController()
    fileprivate var startOffsetX : CGFloat = 0
    
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.bounds.width, height: self.bounds.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollsToTop = false
        return collectionView
    }()
    
    init(frame : CGRect , childVcs : [LDAnchorViewController] , parent : UIViewController) {
        self.childVcs = childVcs
        self.parent = parent
        
        super.init(frame: frame)
        print(frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LDContentView {
    fileprivate func setupUI(){
        
        // 添加conllection
        addSubview(collectionView)
        
        for vc in childVcs {
            parent.addChildViewController(vc)
        }
        
    }
}


// MARK:- UICollectionViewDataSource
extension LDContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}


// MARK:- UICollectionViewDelegate
extension LDContentView : UICollectionViewDelegate {
    // 开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    // 停止滚动
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        scrollEnd(scrollView)
    }
    
    // 手动拖拽时停止
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false {
            scrollEnd(scrollView)
        }
    }
    
    // 滚动停止的事件处理
    private func scrollEnd(_ scrollView : UIScrollView){
        // 记录偏移量
        let offsetX = scrollView.contentOffset.x - startOffsetX
        let targetIndex = scrollView.contentOffset.x / bounds.width
        
        // 通知titleview做点击选中处理
        delegate?.contentView(self, targetIndex: Int(targetIndex), progress: offsetX)
    }
}

// MARK:- 实现titleView的代理方法
extension LDContentView : LDTitleViewDelegate{
    func titleView(_ titleView : LDTitleView, targetIndex : Int) {
        let indexPath = IndexPath.init(row: targetIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .right, animated: false)
    }
}


