//
//  LDProfileViewController.swift
//  LDZBLiving
//
//  Created by 李丹 on 17/8/2.
//  Copyright © 2017年 LD. All rights reserved.
//

import UIKit

class LDProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
        view.backgroundColor = UIColor.randomColor()
    }
    
    private func setUpUI(){
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
