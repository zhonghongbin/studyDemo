//
//  NetworkTools.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/19.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType{
    case POST
    case GET
}
class NetworkTools {
    class func requestData(type:MethodType ,url:String,parameters:[String: Any]? = nil,finshCallback : @escaping(_ result : Any) ->()) {
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(url, method: method, parameters: parameters).responseJSON{(reponse) in
            guard let result = reponse.result.value else{
                print(reponse.result.error)
                return
            }
            //将结果回调出去
            finshCallback(result)
        }
            
    }
}
