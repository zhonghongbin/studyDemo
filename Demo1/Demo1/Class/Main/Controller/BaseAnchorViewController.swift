//
//  BaseAnchorViewController.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/27.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

//
//  BaseAnchorViewController.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/27.
//  Copyright © 2020 钟宏彬. All rights reserved.
//
//娱乐fun及推荐recommend页面的父类控制器
let kItemMargin :CGFloat = 10
let kItemW  : CGFloat = (kScreenW - 3*kItemMargin)/2
let kNormalItemH : CGFloat = kItemW * 3 / 4
let kPrettyItemH : CGFloat = kItemW * 4 / 3
private let kHeaderH : CGFloat = 50

private let kNormalID  = "kNormalID"
let kPrettyID  = "kPrettyID"
private let kHeaderID  = "kHeaderID"
class BaseAnchorViewController : UIViewController {
    var baseVM : BaseViewModel?
    lazy var collectionView : UICollectionView = {
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
extension BaseAnchorViewController{
    @objc func setupUI(){
        view.addSubview(collectionView)
    }
    @objc func getHttp(){
    }
}

extension BaseAnchorViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //获取data下detail组数量
//        if baseVM == nil {
//            return 1
//        }
        return baseVM?.model.data?.count ?? 0
    }
    //每组下item数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if baseVM == nil {
//            return 20
//        }
        let group = baseVM?.model.data?[section]
        return group?.room_list!.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalID, for: indexPath) as! CollectionViewNormalCell
//        if baseVM == nil {
//            return cell
//        }
        let group = baseVM?.model.data?[indexPath.section]
        let item = group?.room_list?[indexPath.item]
        cell.item = item
        return cell
        
    }
    //设置header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderID, for: indexPath) as!CollectionHeaderView
//        if baseVM == nil {
//            return headerView
//        }
        headerView.group = baseVM?.model.data?[indexPath.section]
        
        return headerView
    }
    

}
extension BaseAnchorViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let room = baseVM?.model.data?[indexPath.section].room_list?[indexPath.item]
        
        room?.isVertical == 0 ? pushRoom() : showRoom()
    }
    private func showRoom(){
        let showVc = RoomShowViewController()
        
        present(showVc, animated: true, completion: nil)
    }
    private func pushRoom(){
        let pushVc = RoomViewController()
        navigationController?.pushViewController(pushVc, animated: true)
    }
}

