//
//  GameCell.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/24.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
import Kingfisher
class GameCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    var gameData : DetailData?{
        didSet{
            iconImage.kf.setImage(with: URL(string: gameData?.icon_url ?? ""),placeholder: UIImage(named: "youxi"))
            name.text = gameData?.tag_name
        }
    }
}
