//
//  FunViewModel.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/27.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
import SwiftyJSON

class FunViewModel : BaseViewModel{
    
}
extension FunViewModel{
    func loadData (finishCallback : @escaping()->()) {
        //请求数据
        requestData (url: "http://capi.douyucdn.cn/api/v1/getHotRoom/2",finishCallback: finishCallback)
    }
}
