//
//  CollectionHeaderView.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/18.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleTabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var group : DetailData?{
        didSet{
            titleTabel.text=group?.tag_name
            image.kf.setImage(with: URL(string: group?.icon_url ?? "youxi"))
        }
    }
}
