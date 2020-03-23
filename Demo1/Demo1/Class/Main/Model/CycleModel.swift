//
//  CycleModel.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/23.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import SwiftyJSON

struct CycleModel {
    var error : Int = 0
    var data : [Data]?
    init(jsonData:JSON) {
        error = jsonData["error"].intValue
        data = Data.modelArray(jsonArray: jsonData["data"].arrayValue)
    }
}
struct Data {
    var title : String?
    var pic_url : String?
    
    var room: [DataList]?
    
    
    init(jsonData:JSON) {
        title = jsonData["title"].stringValue
        pic_url = jsonData["pic_url"].stringValue
        room = DataList.modelArray(jsonArray: jsonData["room"].arrayValue)
    }
    static func modelArray(jsonArray:[JSON]) -> [Data] {
        
        var modelArray = [Data]()
        for json in jsonArray {
            modelArray.append(Data(jsonData : json))
        }
        return modelArray
    }

}
//struct Room {
//    var room_src : String?
//    var vertical_src:String?
//    var room_name:String?
//
//    init(jsonData:JSON) {
//        room_src = jsonData["room_src"].stringValue
//        vertical_src = jsonData["vertical_src"].stringValue
//        room_name = jsonData["room_name"].stringValue
//    }
//    static func modelArray(jsonArray:[JSON]) -> [Room] {
//
//        var modelArray = [Room]()
//        for json in jsonArray {
//            modelArray.append(Room(jsonData : json))
//        }
//        return modelArray
//    }
//}
