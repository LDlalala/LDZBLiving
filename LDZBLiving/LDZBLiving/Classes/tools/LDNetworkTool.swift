//
//  LDNetworkTool.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/10.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class LDNetworkTool {

    class func requestData(_ type : MethodType , URLString : String ,parameters : [String : Any]? = nil , finishedCallback : @escaping (_ result : Any) -> Void) {
        // 获取网络请求方式
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 请求数据
        Alamofire.request(URLString, method: method, parameters: parameters).validate(contentType: ["text/plain"]).responseJSON { (response) in
            
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
    
}
