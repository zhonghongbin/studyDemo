//
//  BaseViewModel.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/27.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaseViewModel {
    var model:AnchorModel = AnchorModel()
}
extension BaseViewModel{
    func requestData (url: String ,parameters : [String:Any]?=nil,finishCallback : @escaping()->()) {
        //请求数据
        NetworkTools.requestData(type: .GET, url: url,parameters: parameters){(response) in
            let jsonData = JSON(response)
            self.model = AnchorModel(jsonData: jsonData)
            finishCallback()
        }
    }
}
