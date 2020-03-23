//
//  RecommendCycleView.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/23.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
private let kCycleID = "kCycleID"
class RecommendCycleView: UIView {
    var cycleModel : CycleModel? {
        //监听数据改变
        didSet{
            collectionView.reloadData()
            //重新加载数据，会执行datasource中方法
            pageControl.numberOfPages = cycleModel?.data?.count ?? 0
        }
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "CycleViewCell", bundle: nil), forCellWithReuseIdentifier: kCycleID)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

extension RecommendCycleView{
    class func recommendCycleView() -> RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
    
}
extension RecommendCycleView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModel?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleID, for: indexPath) as! CycleViewCell
        cell.data = cycleModel?.data?[indexPath.item]
        return cell
    }
    
}
