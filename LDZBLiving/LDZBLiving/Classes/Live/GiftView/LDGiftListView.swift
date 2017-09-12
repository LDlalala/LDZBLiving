//
//  LDGiftListView.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/19.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

private let cellID = "LDGiftViewCell"
class LDGiftListView: UIView , NibLoadable{

    
    // MARK: 控件属性
    @IBOutlet weak var giftView: UIView!
    @IBOutlet weak var sendGiftBtn: UIButton!

    
    var  giftVM : LDGiftViewModel = LDGiftViewModel()
    var pageCollectionView : LDPageCollectionView!
    
}

// MARK:- 初始化子控件
extension LDGiftListView{

    override func awakeFromNib() {
        super.awakeFromNib()
        // 初始化子控件
        setupUI()
        // 加载礼物数据
        loadGiftDatas()
        
    }
    
    
    
    private func setupUI(){
        let frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        let layout = LDPageCollectionViewLayout()
        layout.cols = 4
        layout.row = 2
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let style = LDPageStyle()
        
        let pageCollectionView = LDPageCollectionView(frame: frame, titles: ["热门", "高级", "豪华", "专属"], isTitleInTop: false, layout: layout, style: style)
        pageCollectionView.dataSource = self
        pageCollectionView.delegate = self
        addSubview(pageCollectionView)
        
        // 注册cell
        pageCollectionView.register(nib: UINib(nibName: "LDGiftViewCell", bundle: nil), identifier: cellID)
    }
    
    private func loadGiftDatas(){
        giftVM.loadGiftDatas {
            self.pageCollectionView.reloadData()
        }
    }
}



// MARK:- 送礼物
extension LDGiftListView {
    @IBAction func sendGiftBtnClick() {
        
        
        
    }
}

// MARK:- 实现代理方法
extension LDGiftListView : LDPageCollectionViewDelegate{
    func collectionView(_ pageCollectionView: LDPageCollectionView, _ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let giftModel = giftVM.giftlistDatas[indexPath.section].list[indexPath.item]
        print(giftModel)
    }
}

// MARK:-  实现数据源方法
extension LDGiftListView : LDPageCollectionViewDataSource{
    func numberOfSections(in pageCollectionView: LDPageCollectionView) -> Int {
        return  giftVM.giftlistDatas.count
    }
    
    func collectionView(_ pageCollectionView: LDPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        return giftVM.giftlistDatas[section].list.count
    }
    
    func collectionView(_ pageCollectionView: LDPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! LDGiftViewCell
        cell.giftModel = giftVM.giftlistDatas[indexPath.section].list[indexPath.item]
        return cell
    }
}


