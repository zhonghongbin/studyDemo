//
//  CollectionBaseCell.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/23.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var sourceImage: UIImageView!
    var item : DataList?{
        didSet{
            guard let item = item else {
                return
            }
            name.text=item.room_name
            sourceImage.kf.setImage(with: URL(string: item.vertical_src ?? ""),placeholder: UIImage(named: "dota"))
        }
    }
}
