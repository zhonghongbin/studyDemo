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
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kHeaderH : CGFloat = 50

private let kNormalID  = "kNormalID"
private let kPrettyID  = "kPrettyID"
private let kHeaderID  = "kHeaderID"
class RecommendViewController: UIViewController {
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        //设置layout中header大小
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        //根据父布局适配宽高防止流水布局底部显示不全
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        //注册cell item
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyID)
        //注册header
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderID)

        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getHttp()
    }
    
}
extension RecommendViewController{
    private func setupUI(){
        view.addSubview(collectionView)
    }
    private func getHttp(){
        recommendVM.requestData(){
            self.collectionView.reloadData()
        }
    }
}

extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //获取data下detail组数量
        return recommendVM.detail.count
    }
    //每组下item数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.detail[section]
        return group.room_list!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell!
        
        if indexPath.section == 1{
             cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyID, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalID, for: indexPath)
        }

        return cell
    }
    //设置header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath) as!CollectionHeaderView
        headerView.group = recommendVM.detail[indexPath.section]
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1{
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
