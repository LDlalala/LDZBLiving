//
//  LDWaterFallFlowLayout.swift
//  流水布局swift
//
//  Created by 李丹 on 17/8/4.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

// 数据源方法
protocol LDWaterFallFlowLayoutDateSource : class {
    func waterFall(_ waterFall : LDWaterFallFlowLayout ,indexpath : IndexPath) -> CGFloat
    func numOfSection(_ waterFall : LDWaterFallFlowLayout) -> Int
}

class LDWaterFallFlowLayout: UICollectionViewFlowLayout {
    
    weak var dateSource : LDWaterFallFlowLayoutDateSource?
    fileprivate lazy var cols : Int = {
        return self.dateSource?.numOfSection(self) ?? 2
    }()
    
    fileprivate lazy var attrArrs : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]();
    
    fileprivate lazy var cellHeights : [CGFloat] = Array(repeating: self.sectionInset.top, count: self.cols)
    
    fileprivate var startIndex = 0
}

// MARK:- 提前布局
extension LDWaterFallFlowLayout {
    override func prepare() {
        super.prepare()
        // 获取collectionView中的个数
        let itemsCount = collectionView!.numberOfItems(inSection: 0)

        
        let cellW = (collectionView!.bounds.width -  sectionInset.left - sectionInset.right - CGFloat(cols - 1) * minimumInteritemSpacing) / CGFloat(cols)
        
        
        for i in startIndex..<itemsCount {
            // 创建Attributes对象
            let indexPath = NSIndexPath(item: i, section: 0)
            let attr : UICollectionViewLayoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
            
            // 找出最小的高度
            let minH = cellHeights.min()!
            // 找到最小值的索引
            let minIndex = cellHeights.index(of: minH)!

            let cellX = sectionInset.left + (cellW + minimumInteritemSpacing) * CGFloat(minIndex)
            // 设置随机高度值
            let cellH = dateSource?.waterFall(self, indexpath: indexPath as IndexPath) ?? 100
            let cellY = minH
            
            attr.frame = CGRect(x: cellX, y: cellY, width: cellW, height: CGFloat(cellH))
            attrArrs.append(attr)
            // 更新最新的高度
            cellHeights[minIndex] = minH + CGFloat(cellH) + minimumLineSpacing
            
        }
        
        startIndex = itemsCount
    }
}

// MARK:- 返回计算好的布局属性数组
extension LDWaterFallFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrArrs
    }
}


// MARK:- 重新计算contentsize
extension LDWaterFallFlowLayout {
    override var collectionViewContentSize: CGSize{
        return CGSize(width: 0, height: cellHeights.max()! + minimumLineSpacing)
    }
}


