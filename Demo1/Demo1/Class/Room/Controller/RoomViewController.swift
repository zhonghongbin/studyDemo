//
//  RoomViewController.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/30.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController ,UIGestureRecognizerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
    }
    //当view即将出现时调用，用来隐藏navigationbar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //添加手势
        //系统手势，只支持最左侧
//        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
