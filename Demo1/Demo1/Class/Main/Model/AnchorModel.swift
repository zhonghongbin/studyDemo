//
//  AnchorModel.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/20.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import SwiftyJSON

struct AnchorModel {
    var error : Int = 0
    var data : [DetailData]?
    init(jsonData:JSON) {
        error = jsonData["error"].intValue
        data = DetailData.modelArray(jsonArray: jsonData["data"].arrayValue)
    }
    

}
struct DetailData {
    var tag_name : String?
    var room_list: [DataList]?
    
    
    init(jsonData:JSON) {
        tag_name = jsonData["tag_name"].stringValue
        room_list = DataList.modelArray(jsonArray: jsonData["room_list"].arrayValue)
    }
    static func modelArray(jsonArray:[JSON]) -> [DetailData] {
        
        var modelArray = [DetailData]()
        for json in jsonArray {
            modelArray.append(DetailData(jsonData : json))
        }
        return modelArray
    }

}

struct DataList {
    var room_id : String?
    var vertical_src:String?
    init(jsonData:JSON) {
        room_id = jsonData["room_id"].stringValue
        vertical_src = jsonData["vertical_src"].stringValue
    }
    static func modelArray(jsonArray:[JSON]) -> [DataList] {
        
        var modelArray = [DataList]()
        for json in jsonArray {
            modelArray.append(DataList(jsonData : json))
        }
        return modelArray
    }
}
