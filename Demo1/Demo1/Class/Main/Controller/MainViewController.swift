//
//  MainViewController.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/12.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
//注意：记得在storyboard文件viewController中关联class
class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVc(storyName: "Home")
        addChildVc(storyName: "Live")
        addChildVc(storyName: "Attention")
        addChildVc(storyName: "My")
        
    }
    private func addChildVc(storyName: String){
        //通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil)
            //可选类型！解包
            .instantiateInitialViewController()!
        addChild(childVc)
    }
}
