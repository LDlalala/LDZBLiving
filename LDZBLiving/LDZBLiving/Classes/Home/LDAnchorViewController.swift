//
//  LDAnchorViewController.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/7.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

private let homeColCellID = "homeColCellID"

class LDAnchorViewController: UIViewController {

    lazy var homeVM : LDHomeViewModel = LDHomeViewModel()
    // MARK:- 外界传值
    var homeType : LDHomeType!
    
    fileprivate lazy var collectionView : UICollectionView = {
        let frame = CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: Int(self.view.frame.height) - KNavgationBarH - 2 * KTabBarH)
        let layout = LDWaterFallFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        layout.dateSource = self
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.randomColor()
        // 添加collectionView
        view.addSubview(collectionView)
        // 注册cell
        collectionView.register(UINib(nibName: "LDHomeColCell", bundle: nil), forCellWithReuseIdentifier: homeColCellID)

        // 请求数据
        loadData(index: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK:- 请求数据
extension LDAnchorViewController {
    
    func loadData(index : Int){
        homeVM.loadHomeData(type: homeType, index: index, finishedCallback: {
            self.collectionView.reloadData()
        })
    }
    
}

// MARK:- 流水布局的数据源设置
extension LDAnchorViewController : LDWaterFallFlowLayoutDateSource{
    func numOfSection(_ waterFall: LDWaterFallFlowLayout) -> Int {
        return 2
    }
    
    func waterFall(_ waterFall: LDWaterFallFlowLayout, indexpath indexPath: IndexPath) -> CGFloat {
        return indexPath.item % 2 == 0 ? KScreenW * 2 / 3 : KScreenW * 0.5
    }
    
}

// MARK:- UICollectionViewDataSource
extension LDAnchorViewController : UICollectionViewDataSource ,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(homeVM.anchorModels.count)
        return homeVM.anchorModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeColCellID, for: indexPath) as! LDHomeColCell
        cell.backgroundColor = UIColor.randomColor()
        
        cell.anchorModel = homeVM.anchorModels[indexPath.item]
        
        // 加载更多数据
        if indexPath.item == homeVM.anchorModels.count - 1 {
            loadData(index: homeVM.anchorModels.count)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let RoomVC = RoomViewController()
        RoomVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(RoomVC, animated: true)
    }
}

