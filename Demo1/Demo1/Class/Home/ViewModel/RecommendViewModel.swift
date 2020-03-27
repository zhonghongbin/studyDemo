//
//  RecommendViewModel.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/20.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecommendViewModel : BaseViewModel{
    var cycleModel: CycleModel?
    
}

extension RecommendViewModel{
    func loadData (finishCallback : @escaping()->()) {
        let dGroup = DispatchGroup.init()
        dGroup.enter()
        //请求数据
        requestData(url: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":"4","offset" : "0","time":Date.getCurrentTime()]) {
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
