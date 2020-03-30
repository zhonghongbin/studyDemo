//
//  FunMenuCell.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/30.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
private let kGameID = "kGameID"
class FunMenuCell: UICollectionViewCell {
    var model : [DetailData]?{
        didSet{
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "GameCell", bundle: nil), forCellWithReuseIdentifier: kGameID)
    }
    override func layoutSubviews() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }

}
extension FunMenuCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameID, for: indexPath) as! GameCell
        cell.gameData = model?[indexPath.item]
        cell.clipsToBounds = true
        return cell
    }
    
    
}
