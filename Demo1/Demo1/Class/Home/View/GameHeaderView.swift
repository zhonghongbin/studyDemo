//
//  GameHeaderView.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/26.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

class GameHeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    
}

extension GameHeaderView{
    class func headerView()->GameHeaderView{
        return Bundle.main.loadNibNamed("GameHeaderView", owner: nil, options: nil)?.first as!GameHeaderView
    }
}
