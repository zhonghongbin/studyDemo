//
//  GameViewController.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/26.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
private let kMarginW :CGFloat = 10
private let kGameItemW :CGFloat = (kScreenW - 2*kMarginW)/3
private let kGameItemH:CGFloat = kGameItemW * 6 / 5
//全部header高度
private let kAllHeaderH:CGFloat = 50
private let kGameID = "kGameID"
private let kGameHeaderID = "kGameHeaderID"
//游戏列表高度
private let kGameH :CGFloat = 90

class GameViewController: UIViewController {
    //由于GameViewModel下接口请求报错暂用RecommendViewModel请求数据替代
    private lazy var gameVM :RecommendViewModel = RecommendViewModel()
    //顶部headerview
    private lazy var topHeader : GameHeaderView = {
        let header = GameHeaderView.headerView()
        header.frame = CGRect(x: 0, y: -(kAllHeaderH+kGameH), width: kScreenW, height: kAllHeaderH)
        header.titleLabel.text = "游戏"
        return header
    }()
    //顶部游戏列表view
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.gameView()
        gameView.frame = CGRect(x: 0, y: -kGameH, width: kScreenW, height: kGameH)
        return gameView
    }()
    //全部游戏列表
    private lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kGameItemW, height: kGameItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kMarginW, bottom: 0, right: kMarginW)
         layout.headerReferenceSize = CGSize(width: kScreenW, height: kAllHeaderH)
        let collection = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
         collection.register(UINib(nibName: "GameCell", bundle: nil), forCellWithReuseIdentifier: kGameID)
        collection.register(UINib(nibName: "GameHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kGameHeaderID)
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        //根据父布局适配宽高防止流水布局底部显示不全
        collection.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        return collection
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getHttp()
    }

}
extension GameViewController{
    fileprivate func setupUI(){
        //添加collectionView
        view.addSubview(collectionView)
        //添加顶部header
        collectionView.addSubview(topHeader)
                collectionView.addSubview(gameView)
        //添加collectionView内边距，用来显示顶部游戏列表
        collectionView.contentInset = UIEdgeInsets(top: kAllHeaderH
            + kGameH, left: 0, bottom: 0, right: 0)

    }
    private func getHttp(){
        gameVM.loadData {
            self.collectionView.reloadData()
            self.gameView.totalData = self.gameVM.model
        }
    }
}


extension GameViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.model.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameID, for: indexPath)as!GameCell
        cell.gameData = gameVM.model.data?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
        withReuseIdentifier: kGameHeaderID, for: indexPath) as! GameHeaderView
        headerView.titleLabel.text = "全部"
        return headerView
    }
    
}
