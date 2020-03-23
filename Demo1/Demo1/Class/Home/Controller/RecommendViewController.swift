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

private let kCycleH :CGFloat = kScreenW * 3/8

private let kNormalID  = "kNormalID"
private let kPrettyID  = "kPrettyID"
private let kHeaderID  = "kHeaderID"
class RecommendViewController: UIViewController {

    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    private lazy var recommecdCV :RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleH, width: kScreenW, height: kCycleH)
        return cycleView
    }()
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
        //添加轮播view
        collectionView.addSubview(recommecdCV)
        //设置collectionview内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleH, left: 0, bottom: 0, right: 0)
    }
    private func getHttp(){
        recommendVM.requestData(){
            self.collectionView.reloadData()
        }
        recommendVM.requestCycleData {
            self.recommecdCV.cycleModel = self.recommendVM.cycleModel
        }
    }
}

extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //获取data下detail组数量
        return recommendVM.model?.data?.count ?? 0
    }
    //每组下item数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.model?.data?[section]
        return group?.room_list!.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let group = recommendVM.model?.data?[indexPath.section]
        let item = group?.room_list?[indexPath.item]
        
        if indexPath.section == 1{
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyID, for: indexPath) as! CollectionPrettyCell
            cell.item = item
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalID, for: indexPath) as! CollectionViewNormalCell
            cell.item = item
            return cell
        }

    }
    //设置header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath) as!CollectionHeaderView
        headerView.group = recommendVM.model?.data?[indexPath.section]
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1{
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
