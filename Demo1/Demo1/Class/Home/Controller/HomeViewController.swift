//
//  HomeViewController.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/13.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}
//设置ui界面抽取方法，使viewDidLoad调用时更清晰
extension HomeViewController{
    private func setupUI(){
        //设置顶部导航栏
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        //设置左侧按钮
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        //设置内边距
        btn.contentEdgeInsets = UIEdgeInsets(top: -10, left: -40, bottom: 10, right: 0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        let historyItem = UIBarButtonItem(imageName: "history", leftPadding: 40, rightPadding: 0)
        
        let searchItem = UIBarButtonItem(imageName: "search", leftPadding: -60, rightPadding: 20)
        
        let qrcodeItem = UIBarButtonItem(imageName: "qrcode", leftPadding: -20, rightPadding: 0)
        navigationItem.rightBarButtonItems = [qrcodeItem,searchItem,historyItem]
    }
}
