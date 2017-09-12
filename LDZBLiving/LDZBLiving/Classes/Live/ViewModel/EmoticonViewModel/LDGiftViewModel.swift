//
//  LDGiftViewModel.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/21.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

class LDGiftViewModel {

    var giftlistDatas : [GiftPackage] = [GiftPackage]()
    
    
}

extension LDGiftViewModel{
    func loadGiftDatas(finishedCallBack : @escaping () -> ()) {
        LDNetworkTool.requestData(.get, URLString: "http://qf.56.com/pay/v4/giftList.ios", parameters: ["type" : 0, "page" : 1, "rows" : 150], finishedCallback: { result in
            
            guard let resultDict = result as? [String : Any] else {return}
            
            guard let dataDict = resultDict["message"] as? [String : Any] else {return}
            
            for i in 0..<dataDict.count{
                guard let dict = dataDict["type\(i+1)"] as? [String : Any] else {return}
                self.giftlistDatas.append(GiftPackage(dict:dict))
            }
            
            // 过滤数据 和 对数据排序
            self.giftlistDatas = self.giftlistDatas.filter({return $0.t != 0}).sorted(by: {return $0.t > $1.t})
            
            finishedCallBack()
        })
    }
}
