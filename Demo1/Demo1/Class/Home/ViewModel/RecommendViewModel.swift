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
    var model:AnchorModel?
    var cycleModel: CycleModel?
//    lazy var detail : [DetailData] = [DetailData]()
//    private lazy var datalist : [DataList] = [DataList]()
}

extension RecommendViewModel{
    func requestData (finishCallback : @escaping()->()) {
        let dGroup = DispatchGroup.init()
        dGroup.enter()
        //请求数据
        NetworkTools.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":"4","offset" : "0","time":Date.getCurrentTime()]){(response) in
            let jsonData = JSON(response)
            self.model = AnchorModel(jsonData: jsonData)
//            guard let detail : [DetailData] =  self.model?.data else{return}
//            for xxx in detail{
//                self.detail.append(xxx)
//                guard let roomlist : [DataList] =  xxx.room_list else {return}
//                for yyy in roomlist{
//                    self.datalist.append(yyy)
//                }
//            }
            dGroup.leave()
        }
        dGroup.notify(queue: .main) {
            finishCallback()
        }

    }
    func requestCycleData(finishCallback : @escaping()->()) {
        NetworkTools.requestData(type: .GET, url: "http://www.douyutv.com/api/v1/slide/6",parameters: ["version" : "2.300"]) { (result) in
            let jsonData = JSON(result)
            self.cycleModel = CycleModel(jsonData: jsonData)
            finishCallback()
        }
    }
}
