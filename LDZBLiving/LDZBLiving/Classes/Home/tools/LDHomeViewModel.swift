//
//  LDHomeViewModel.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/11.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

class LDHomeViewModel {

     lazy var anchorModels : [LDAnchorModel] = [LDAnchorModel]()
}

extension LDHomeViewModel {
    func loadHomeData(type : LDHomeType , index : Int , finishedCallback : @escaping () -> ()) {
        LDNetworkTool.requestData(.get, URLString: "http://qf.56.com/home/v4/moreAnchor.ios", parameters: ["type" : type.type, "index" : index, "size" : 48], finishedCallback: { (result) -> Void in
            
            guard let resultDict = result as? [String : Any] else {return}
            guard let massageDict = resultDict["message"] as? [String : Any] else {return}
            guard let dataArray = massageDict["anchors"] as? [[String : Any]] else {return}
            
            // 解析数据
            for (index,dict) in dataArray.enumerated(){
                let anchor = LDAnchorModel(dict:dict)
                anchor.isEvenIndex = index%2 == 0
                self.anchorModels.append(anchor)
            }
            
            finishedCallback()
        })
    }
}
