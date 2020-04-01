//
//  RecommendViewController.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/17.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit




private let kCycleH :CGFloat = kScreenW * 3/8
private let kGameH :CGFloat = 90
class RecommendViewController: BaseAnchorViewController {
    
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    private lazy var recommecdCV :RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleH+kGameH), width: kScreenW, height: kCycleH)
        return cycleView
    }()
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.gameView()
        gameView.frame = CGRect(x: 0, y: -kGameH, width: kScreenW, height: kGameH)
        return gameView
    }()
    
}
extension RecommendViewController{
    
    override func setupUI() {
        super.setupUI()
        view.addSubview(collectionView)
        //添加轮播view
        collectionView.addSubview(recommecdCV)
        //设置collectionview内边距
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kCycleH + kGameH, left: 0, bottom: 0, right: 0)
    }
    
    override func getHttp() {
        //给父类vm添加数据
        baseVM = recommendVM
        
        recommendVM.loadData(){
            self.collectionView.reloadData()
            //game列表设置数据
            self.gameView.totalData = self.recommendVM.model
        }
        //轮播数据请求
        recommendVM.requestCycleData {
            self.recommecdCV.cycleModel = self.recommendVM.cycleModel
        }
        self.loadDataFinish()
    }
}
//拓展协议，实现不同item大小的流水布局
extension RecommendViewController : UICollectionViewDelegateFlowLayout{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyID, for: indexPath) as! CollectionPrettyCell
            cell.item = recommendVM.model.data?[indexPath.section].room_list?[indexPath.item]
            return cell
        }else{
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1{
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}

