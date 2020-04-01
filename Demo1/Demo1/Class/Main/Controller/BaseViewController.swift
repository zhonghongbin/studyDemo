//
//  BaseViewController.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/31.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var contentView : UIView?
    private lazy var image : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "loading"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "loading")!,UIImage(named: "loading2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}
extension BaseViewController{
    @objc func setupUI(){
        //隐藏内容布局，需要给contentView赋值
        contentView?.isHidden = true
        view.backgroundColor = UIColor.white
        view.addSubview(image)
        //启动加载动画
        image.startAnimating()
    }
    //完成数据加载
    func loadDataFinish(){
        //停止动画
        image.stopAnimating()
        //隐藏加载动画
        image.isHidden = true
        //显示内容
        contentView?.isHidden = false
    }
}
