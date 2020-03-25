//
//  Common.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/13.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

let kStatusBarH :CGFloat = isNotchScreen == true ? 60 : 20
let kNavigationBarH : CGFloat = 40
let kTabBarH : CGFloat = 40
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
// iPhoneX、iPhoneXR、iPhoneXs、iPhoneXs Max等
// 判断刘海屏，返回true表示是刘海屏
var isNotchScreen: Bool {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            return false
        }
        
        let size = UIScreen.main.bounds.size
        let notchValue: Int = Int(size.width/size.height * 100)
        
        if 216 == notchValue || 46 == notchValue {
            
            return true
        }
        
        return false
    }
