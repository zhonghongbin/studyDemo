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
    init() {
        
    }
    init(jsonData:JSON) {
        error = jsonData["error"].intValue
        data = DetailData.modelArray(jsonArray: jsonData["data"].arrayValue)
    }
    

}
struct DetailData {
    var tag_name : String?
    var icon_url : String?
    
    var room_list: [DataList]?
    
    init() {
        
    }
    init(jsonData:JSON) {
        tag_name = jsonData["tag_name"].stringValue
        icon_url = jsonData["icon_url"].stringValue
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
    var room_src : String?
    var vertical_src:String?
    var room_name:String?
    var avatar_small : String?
    var isVertical : Int?
    
    
    init(jsonData:JSON) {
        room_id = jsonData["room_id"].stringValue
        room_src = jsonData["room_src"].stringValue
        vertical_src = jsonData["vertical_src"].stringValue
        room_name = jsonData["room_name"].stringValue
        avatar_small = jsonData["avatar_small"].stringValue
        isVertical = jsonData["isVertical"].intValue
    }
    static func modelArray(jsonArray:[JSON]) -> [DataList] {
        
        var modelArray = [DataList]()
        for json in jsonArray {
            modelArray.append(DataList(jsonData : json))
        }
        return modelArray
    }
}
