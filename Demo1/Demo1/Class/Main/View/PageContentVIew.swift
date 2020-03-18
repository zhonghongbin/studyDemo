//
//  PageContentVIew.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/16.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class{
    func pageContentView(contentView : PageContentView,progress : CGFloat,sourceIndex: Int ,targetIndex : Int)
}
private let cellID = "cellID"
class PageContentView: UIView {
    //是否禁用scroll标记
    private var isForbidScroll :Bool = false
    private var startOffetX :CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    private var childVcs : [UIViewController]
    //弱引用防止循环引用
    private weak var parentViewController : UIViewController?
    private lazy var collectionView :UICollectionView = {[weak self] in
        //创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        //分页设置
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        //获取协议
        collectionView.delegate = self
        //绑定数据源
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        //注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
    
    init(frame:CGRect,childVcs : [UIViewController],parentViewController : UIViewController?){
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame : frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView{
    private func setupUI(){
        for childVc in childVcs{
            //将所有子view控制器添加到父控制器中
            parentViewController?.addChild(childVc)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}
//遵循UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource{
    //实现以下两个方法
    //item数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    //item下表
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //cell类似android复用器,使用前需注册
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        //给cell设置内容
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
    
    
}
extension PageContentView{
    func setCurrentIndex(currentIndex : Int) {
        isForbidScroll = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0),animated: false)
    }
}
extension PageContentView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //是否禁用scroll
        isForbidScroll = false
        startOffetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScroll {return}
        //滑动进度
        var progress : CGFloat = 0
        var sourceIndex = 0
        var targetIndex = 0
        //判断左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if(currentOffsetX > startOffetX){//左滑
            //floor为取整
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
            
            sourceIndex = Int(currentOffsetX/scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count-1
            }
            if currentOffsetX - startOffetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
        }else{//右滑
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            targetIndex = Int(currentOffsetX/scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count-1
            }
        }
        //传递index给titleview
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
