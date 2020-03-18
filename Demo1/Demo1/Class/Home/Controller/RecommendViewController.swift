//
//  RecommendViewController.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/17.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

private let kItemMargin :CGFloat = 10
private let kItemW  : CGFloat = (kScreenW - 3*kItemMargin)/2
private let kItemH : CGFloat = kItemW * 3 / 4
private let kHeaderH : CGFloat = 50

private let kNormalID  = "kNormalID"
private let kHeaderID  = "kHeaderID"
class RecommendViewController: UIViewController {
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        //设置layout中header大小
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        //根据父布局适配宽高防止流水布局底部显示不全
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        //注册cell item
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalID)
        //注册header
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderID)

        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}
extension RecommendViewController{
    private func setupUI(){
        view.addSubview(collectionView)
    }
}

extension RecommendViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if section == 0 {
            return 8
            }
            return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalID, for: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath)
        return headerView
    }
    
}
