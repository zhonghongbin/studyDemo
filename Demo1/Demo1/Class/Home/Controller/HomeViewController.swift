//
//  HomeViewController.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/13.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

private let kTitleViewH:CGFloat = 40
class HomeViewController: UIViewController {
    //闭包懒加载
    private lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
        }()
    
    private lazy var pageContentView : PageContentView = {[weak self] in
        //确认内容frame
        let contentH : CGFloat = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        //确认所有子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
        }()
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
}
//设置ui界面抽取方法，使viewDidLoad调用时更清晰
extension HomeViewController{
    
    private func setupUI(){
        //设置顶部导航栏
        setupNavigationBar()
        view.addSubview(pageTitleView)
        //添加contentview
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    private func setupNavigationBar(){
        //设置左侧按钮
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        //设置内边距
        btn.contentEdgeInsets = UIEdgeInsets(top: -10, left: -40, bottom: 10, right: 0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        let historyItem = UIBarButtonItem(imageName: "history", leftPadding: 40, rightPadding: 0)
        
        let searchItem = UIBarButtonItem(imageName: "search", leftPadding: -60, rightPadding: 20)
        
        let qrcodeItem = UIBarButtonItem(imageName: "qrcode", leftPadding: -20, rightPadding: 0)
        navigationItem.rightBarButtonItems = [qrcodeItem,searchItem,historyItem]
    }
    
    
}

//遵守协议
extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex index : Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension HomeViewController : PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int){
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
