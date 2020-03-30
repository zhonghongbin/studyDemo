//
//  RecommendViewController.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/17.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit


private let kMenuH :CGFloat = 200
class FunViewController: BaseAnchorViewController {

    private lazy var funVM : FunViewModel = FunViewModel()
    //为了显示view需要在xib中设置autoresizing
    private lazy var funMenuV : FunMenuView = {
        let menuView = FunMenuView.funMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuH, width: kScreenW, height: kMenuH)
        return menuView
    }()
}
extension FunViewController{
    override func setupUI() {
        super.setupUI()
        collectionView.addSubview(funMenuV)
        collectionView.contentInset = UIEdgeInsets(top: kMenuH, left: 0, bottom: 0, right: 0)
    }
    override func getHttp() {
        //给父类vm添加数据
        baseVM = funVM
        //不同数据请求加载数据
        funVM.loadData {
            self.collectionView.reloadData()
            self.funMenuV.model = self.funVM.model
        }
    }
}



