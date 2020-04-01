//
//  CustomNavigationController.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/31.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //全屏pop手势实现
        //获取系统手势
        guard let systemGes = interactivePopGestureRecognizer else{return}
        //获取手势添加到view中
        guard let gesView = systemGes.view else {return}
        
        
        let targets = systemGes.value(forKey: "_targets") as! [NSObject]
        guard let targetObjc = targets.first else {return}
        
        guard let target = targetObjc.value(forKey: "target") else {return}
        let action = Selector(("handleNavigationTransition:"))
        
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
}
