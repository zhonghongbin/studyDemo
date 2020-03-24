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
    var timer : Timer?
    var cycleModel : CycleModel? {
        //监听数据改变
        didSet{
            //重新加载数据，会执行datasource中方法
            collectionView.reloadData()
            //设置pagecontrol个数
            pageControl.numberOfPages = cycleModel?.data?.count ?? 0
            //设置轮播页滚动到中间某个位置，用来使第一张图片可以回滚
            let index = IndexPath(item: (cycleModel?.data?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: index, at: .left, animated: false)
            
            //添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = .init()
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
        return (cycleModel?.data?.count ?? 0) * 9999
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleID, for: indexPath) as! CycleViewCell
        cell.data = cycleModel?.data?[indexPath.item % (cycleModel!.data!.count)]
        return cell
    }
    
}
//代理监听滚动
extension RecommendCycleView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取偏移量
        let offset = scrollView.contentOffset.x
        pageControl.currentPage = Int(offset / scrollView.bounds.width) % (cycleModel?.data?.count ?? 1)
    }
    //拖拽开始时移除定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
     //拖拽结束时添加定时器
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}
extension RecommendCycleView {
    private func addCycleTimer(){
        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    private func removeCycleTimer(){
        //移除定时器
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func scrollToNext(){
        let currentOffset = collectionView.contentOffset.x
        let offsetX = currentOffset + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
