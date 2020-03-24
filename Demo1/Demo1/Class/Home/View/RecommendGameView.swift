//
//  RecommendGameView.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/24.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

private let kGameID = "kGameID"
class RecommendGameView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    var totalData : AnchorModel?{
        didSet{
            var more = DetailData()
            more.tag_name = "更多"
            totalData?.data?.append(more)
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //让控件不随父布局拉伸而拉伸
        autoresizingMask = .init()
        //注册cell
        
        collectionView.register(UINib(nibName: "GameCell", bundle: nil), forCellWithReuseIdentifier: kGameID)
    }
}
extension RecommendGameView{
    class func gameView() -> RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
    
}
extension RecommendGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalData?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameID, for: indexPath) as! GameCell
        cell.gameData = totalData?.data?[indexPath.item]
        return cell
    }
    
    
}
