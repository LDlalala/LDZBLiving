//
//  LDPageCollectionViewLayout.swift
//  自定义表情键盘
//
//  Created by 李丹 on 17/8/11.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

class LDPageCollectionViewLayout: UICollectionViewFlowLayout {
    
    var cols : Int = 4
    var row : Int = 2
    
    fileprivate lazy var attributesArray = [UICollectionViewLayoutAttributes]()
    fileprivate var maxWidth : CGFloat = 0
}

// MARK:- 重新布局
extension LDPageCollectionViewLayout{
    override func prepare() {
        
        // item的宽和高度计算
        let itemW = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(cols - 1)) / CGFloat(cols)
        let itemH = (collectionView!.bounds.height - sectionInset.top - sectionInset.bottom - minimumLineSpacing * CGFloat(row - 1)) / CGFloat(row)
        
        // 获取item的组
        let itemSectionCount = collectionView!.numberOfSections
        
        // 记录前一组中页数
        var prePageCount : Int = 0
        
        for i in 0..<itemSectionCount {
            // 获取单组中item中的个数
            let itemCount = collectionView!.numberOfItems(inSection: i)
            for j in 0..<itemCount{
                
                // 1. 获取对应位置的indexPath
                let indexPath  = IndexPath(item: j, section: i)
                
                // 2. 根据indexPath创建UICollectionViewLayoutAttributes
                let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                // 3. 计算item在该组中的第几页的第几个
                // 3.1. 该组中的第几页
                let page = j / (cols * row)
                // 3.2. 在第几页中的第几个
                let index = j % (cols * row)
                
                // 4. 计算itemX 和 itemY
                let itemX = CGFloat(prePageCount + page) * collectionView!.bounds.width + sectionInset.left + (itemW + minimumInteritemSpacing) * CGFloat(index % cols)
                let itemY = sectionInset.top + (itemH + minimumLineSpacing) * CGFloat(index / cols)
                
                // 设置attribute的frame
                attr.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                
                // 添加到数组中
                attributesArray.append(attr)
            }
            // 前一组中页数
            prePageCount += itemCount / (cols * row) + 1
        }
        
        // 计算最大的宽度
        maxWidth = CGFloat(prePageCount) * collectionView!.bounds.width
        
    }
    
}


// MARK:- 返回计算的所有cell的attribute
extension LDPageCollectionViewLayout{
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArray
    }
}

// MARK:- 重新计算contentsize
extension LDPageCollectionViewLayout{
    override var collectionViewContentSize: CGSize{
        return CGSize(width: maxWidth, height: 0)
    }
}

