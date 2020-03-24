//
//  CycleViewCell.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/23.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

class CycleViewCell: UICollectionViewCell {

    @IBOutlet weak var cycleImage: UIImageView!
    var data : Data?{
        didSet{
            cycleImage.kf.setImage(with: URL(string: data?.pic_url ?? ""),placeholder: UIImage(named: "dota"))
        }
    }
}
