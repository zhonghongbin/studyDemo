//
//  RecommendViewModel.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/20.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecommendViewModel{
    private lazy var detail : [DetailData] = [DetailData]()
    private lazy var datalist : [DataList] = [DataList]()
}

extension RecommendViewModel{
    func requestData () {
        print(Date.getCurrentTime())
        //请求数据
        NetworkTools.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":"4","offset" : "0","time":Date.getCurrentTime()]){(response) in
            let jsonData = JSON(response)
            let model = AnchorModel(jsonData: jsonData)
            guard let detail : [DetailData] =  model.data else{return}
            for xxx in detail{
                self.detail.append(xxx)
                print(xxx.tag_name)
            }
            
        }
    }
}
