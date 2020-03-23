//
//  PageTitleView.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/13.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
//协议只能被类遵守，如果不写可能会被结构体遵守，类似于android的接口回调
protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView ,selectedIndex index: Int)
}
private let normalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let selectedColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)
private let kScrollLineH :CGFloat = 6
class PageTitleView: UIView {
    private var currentIndex : Int = 0
    private var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    private lazy var titleLabels : [UILabel] = [UILabel]()
    private lazy var scrollView :UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    //自定义构造
    init(frame : CGRect ,titles : [String]) {
        self.titles = titles
        
        super.init(frame : frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView{
    private func setupUI(){
        //添加scollView
        addSubview(scrollView)
        scrollView.frame = bounds
        setupTitleLabels()
        setupBottomLine()
    }
    
    private func setupTitleLabels(){
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - CGFloat(kScrollLineH)
        let labelY : CGFloat = 0
        for (index , title) in titles.enumerated(){
            //创建uilabel
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: normalColor.0, g: normalColor.1, b: normalColor.2)
            label.textAlignment = .center
            
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //将label添加至scrollview
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //给label添加手势
            label.isUserInteractionEnabled = true
            let tabGes = UITapGestureRecognizer(target: self, action:#selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tabGes)
        }
    }
    private func setupBottomLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x , y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        scrollLine.backgroundColor = UIColor.orange


    }
}
//设置点击监听
extension PageTitleView{
    //时间需添加objc
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer){
        
        //获取当前点击label ,as?转换
        guard let currentLabel = tapGes.view as? UILabel else{
            return
        }
        //防止重复点击选中的titlelabel颜色问题
        if currentLabel.tag == currentIndex {
            return
        }
        //获取之前label
        let oldLabel = titleLabels[currentIndex]
        //切换文字颜色
        currentLabel.textColor = UIColor(r: selectedColor.0, g: selectedColor.1, b: selectedColor.2)
        oldLabel.textColor = UIColor(r: normalColor.0, g: normalColor.1, b: normalColor.2)
        currentIndex = currentLabel.tag
        //滚动条跟随点击滑动
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        //动画效果
        UIView.animate(withDuration: 0.15){
            self.scrollLine.frame.origin.x = scrollLineX
        }
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}
extension PageTitleView{
    func setTitleWithProgress(progress: CGFloat,sourceIndex : Int ,targetIndex : Int){
        //根据滚动取出label
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        

        
        //处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        //根据进度判断滑动了多少
        let moveX = moveTotalX * progress
        //源位置加上滑动距离得出line滑动了多少
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        //根据progress计算渐变颜色
        let change = (selectedColor.0 - normalColor.0,selectedColor.1 - normalColor.1,selectedColor.2 - normalColor.2)
        sourceLabel.textColor = UIColor(r: selectedColor.0 - change.0*progress, g: selectedColor.1 - change.1*progress, b: selectedColor.2-change.2*progress)
        targetLabel.textColor = UIColor(r: normalColor.0 + change.0*progress, g: normalColor.1 + change.1*progress, b: normalColor.2 + change.2*progress)
        //滚动后改变当前index
        currentIndex = targetIndex
    }
}

