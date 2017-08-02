//
//  LDMainViewController.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/2.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

class LDMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC("LDHomeViewController");
        addChildVC("LDRankViewController")
        addChildVC("LDDiscoverViewController")
        addChildVC("LDProfileViewController")
    }

    private func addChildVC(_ name : String){
        let childVC = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVC)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK:- 
extension LDMainViewController{
    
}


