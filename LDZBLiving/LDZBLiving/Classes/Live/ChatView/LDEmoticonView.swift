//
//  LDEmoticonView.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/21.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

class LDEmoticonView: UIView {

    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // 添加UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK:- 添加UI
extension LDEmoticonView {
    
    func setupUI() {
        let frame = CGRect(x: 0, y: 0, width: KScreenW, height: bounds.height)
        let layout = LDPageCollectionViewLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.cols = 7
        layout.row = 3
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let style = LDPageStyle()
        let pageCollectionView = LDPageCollectionView(frame: frame, titles: ["普通","粉丝专属"], isTitleInTop: false, layout: layout, style: style)
        pageCollectionView.dataSource = self
        addSubview(pageCollectionView)
        
        pageCollectionView.register(nib: UINib(nibName: "LDEmoticonViewCell", bundle: nil), identifier: "LDEmoticonViewCell")
    }
}

// MARK:- 实现代理方法LDPageCollectionViewDataSource
extension LDEmoticonView : LDPageCollectionViewDataSource{
    func numberOfSections(in pageCollectionView: LDPageCollectionView) -> Int {
        
        return EmoticonViewModel.shareEmoticonModel.packages.count
    }
    
    func collectionView(_ pageCollectionView: LDPageCollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return EmoticonViewModel.shareEmoticonModel.packages[section].emoticons.count
    }
    
    func collectionView(_ pageCollectionView: LDPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LDEmoticonViewCell", for: indexPath) as! LDEmoticonViewCell
        cell.emoticon = EmoticonViewModel.shareEmoticonModel.packages[indexPath.section].emoticons[indexPath.item]
        return cell
    }
}

