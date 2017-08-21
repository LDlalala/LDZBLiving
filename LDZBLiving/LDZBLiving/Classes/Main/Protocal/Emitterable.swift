//
//  Emitterable.swift
//  Emittering-粒子运动
//
//  Created by 李丹 on 17/8/11.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

protocol Emitterable : class {


}


// MARK:- 添加协议方法,只要继承自这个协议,那么就可以实现协议
extension Emitterable where Self : UIViewController { // 给一个限制条件

    func startEmittering(_ point : CGPoint) {
        // 创建发射器
        let emitter = CAEmitterLayer()
        
        // 设置发射器位置
        emitter.emitterPosition = point
        
        // 开启三维效果
        emitter.preservesDepth = true
        
        // 创建粒子,并设置栗子相关属性
        var cells = [CAEmitterCell]()
        for i in 0..<10 {
            let cell = CAEmitterCell()
            
            // 设置速度
            cell.velocity = 150
            cell.velocityRange = 100
            
            // 设置栗子大小
            cell.scale = 0.7
            cell.scaleRange = 0.3
            
            // 设置栗子方向c
            cell.emissionLatitude = CGFloat(-M_PI_2)
            cell.emissionRange = CGFloat(M_PI_2 / 6)
            
            // 设置栗子旋转
            cell.spin = CGFloat(M_PI_2)
            cell.spinRange = CGFloat(M_PI_2 / 2)
            
            // 设置栗子每秒弹出的个数
            cell.birthRate = 2
            
            // 设置生命时间
            cell.lifetime = 7
            cell.lifetimeRange = 1.5
            
            // 设置内容图片
            cell.contents = UIImage(named: "good\(i)_30x30")?.cgImage
            
            cells.append(cell)
        }
        
        // 将栗子设置到发射器中
        emitter.emitterCells = cells
        
        // 将发射器的layer添加到父类的layer中
        view.layer.addSublayer(emitter)
    }
    
    
    func stopEmittering() {
        
        view.layer.sublayers?.filter({$0.isKind(of: CAEmitterLayer.self)}).first?.removeFromSuperlayer()
        /*
         for layer in view.layer.sublayers! {
         if layer.isKind(of: CAEmitterLayer.self) {
         layer.removeFromSuperlayer()
         }
         }
         */
    }
}
