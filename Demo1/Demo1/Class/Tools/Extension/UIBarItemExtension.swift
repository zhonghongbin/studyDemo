//
//  UIBarItemExtension.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/13.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
//扩展
extension UIBarButtonItem {
    //扩展中构造必须为convenience修饰的便利构造
    //便利构造中必须明确调用一个设计的构造函数（self）
    convenience init(imageName : String,highImageName : String = "",leftPadding : CGFloat,rightPadding : CGFloat){
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        //设置点击后高亮图片，可选
        if(highImageName != ""){
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
                //设置内边距
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: leftPadding, bottom: 20, right: rightPadding)
        self.init(customView:btn)
    }
}
