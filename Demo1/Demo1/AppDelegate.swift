//
//  AppDelegate.swift
//  Demo1
//
//  Created by 钟宏彬 on 2020/3/12.
//  Copyright © 2020 钟宏彬. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var autoSizeScaleX: Float = 0

    var autoSizeScaleY: Float = 0

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let screenWidth = UIScreen.main.bounds.size.width

        let screenHeight = UIScreen.main.bounds.size.height
        
        if(screenHeight>480){
            autoSizeScaleX = Float(screenWidth) / 320.0
            autoSizeScaleY = Float(screenHeight) / 568.0
        }else{
            autoSizeScaleX = 1.0
            autoSizeScaleY = 1.0
        }


        //设置tabbar默认背景色
        UITabBar.appearance().tintColor = UIColor.orange
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

