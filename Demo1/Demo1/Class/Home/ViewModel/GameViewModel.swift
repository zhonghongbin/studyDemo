//
//  GameViewModel.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/26.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
import SwiftyJSON

class GameViewModel{
    var model:AnchorModel?
}

extension GameViewModel{
    func requestGameData(finishCallback : @escaping()->()) {
        NetworkTools.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getColumnDetail",parameters: ["shortName" : "game"]) { (result) in
            let jsonData = JSON(result)
            self.model = AnchorModel(jsonData: jsonData)
            finishCallback()
        }
    }
}
