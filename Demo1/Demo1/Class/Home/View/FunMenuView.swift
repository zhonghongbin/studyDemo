//
//  FunMenuView.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/27.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

class FunMenuView: UIView {
}
extension FunMenuView{
    class func funMenuView() -> FunMenuView{
        return Bundle.main.loadNibNamed("FunMenuView", owner: nil, options: nil)?.first as! FunMenuView
    }
}
