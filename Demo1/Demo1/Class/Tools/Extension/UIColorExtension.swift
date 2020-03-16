//
//  UIColorExtension.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/16.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r : CGFloat ,g : CGFloat , b : CGFloat){
        self.init(red : r/255.0, green : g/255.0 , blue : b/255.0 ,alpha : 1.0)
    }
}
