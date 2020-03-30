//
//  FunMenuView.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/27.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
private let kMenuID = "kMenuID"
class FunMenuView: UIView {
    var model : AnchorModel?{
        didSet{
            model?.data?.removeFirst()
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func awakeFromNib() {
        collectionView.register(UINib(nibName: "FunMenuCell",bundle: nil), forCellWithReuseIdentifier: kMenuID)
    }
    //在layout中拿到布局正确大小
    override func layoutSubviews() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}
extension FunMenuView{
    class func funMenuView() -> FunMenuView{
        return Bundle.main.loadNibNamed("FunMenuView", owner: nil, options: nil)?.first as! FunMenuView

    }
}
extension FunMenuView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if model == nil {return 0}
        let pageNum = (model!.data!.count - 1)/8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuID, for: indexPath) as! FunMenuCell

        setupCellData(cell: cell, indexPath: indexPath)
        return cell
    }
    private func setupCellData(cell:FunMenuCell,indexPath: IndexPath){
        //0页 1-7
        //1页 8-15
        //2页 16-23
        //取出起始位置和结束位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item+1) * 8 - 1
        //解决越界问题
        if endIndex > model!.data!.count - 1{
            endIndex = model!.data!.count-1
        }
        
        cell.model = Array(model!.data![startIndex...endIndex])
    }
}
extension FunMenuView:UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
