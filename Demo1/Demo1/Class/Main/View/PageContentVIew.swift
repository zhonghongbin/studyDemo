//
//  PageContentVIew.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/16.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

private let cellID = "cellID"
class PageContentView: UIView {
    private var childVcs : [UIViewController]
    private var parentViewController : UIViewController
    private lazy var collectionView :UICollectionView = {
        //创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        //创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        //分页设置
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        //绑定数据源
        collectionView.dataSource = self
        collectionView.scrollsToTop = false
        //注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
    
    init(frame:CGRect,childVcs : [UIViewController],parentViewController : UIViewController){
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
            parentViewController.addChild(childVc)
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
