//
//  DateExtension.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/20.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import Foundation

extension Date{
    static func getCurrentTime()->String
    {
        let date = NSDate()
        let interval = date.timeIntervalSince1970
        return "\(interval)"
    }
}
