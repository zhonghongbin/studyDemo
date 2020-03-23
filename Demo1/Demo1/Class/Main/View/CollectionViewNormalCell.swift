//
//  CollectionViewNormalCell.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/18.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: CollectionBaseCell {


    override var item : DataList?{
        didSet{
            super.item = item
        }
    }
}
