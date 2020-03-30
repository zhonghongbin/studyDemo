//
//  PlayViewController.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/30.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
private let kTopMargin :CGFloat = 10
class PlayViewController: BaseAnchorViewController {
    private lazy var playVM : PlayViewModel = PlayViewModel()
}
extension PlayViewController{
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
    override func getHttp() {
        //给父类vm添加数据
        baseVM = playVM
        //不同数据请求加载数据
        playVM.loadData {
            self.collectionView.reloadData()
        }
    }
}
