//
//  AppDelegate.swift
//  SwiftMain
//
//  Created by Harlan on 2018/12/26.
//  Copyright © 2018 Harlan. All rights reserved.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    lazy var reachabilityManager: NetworkReachabilityManager? = {
        return NetworkReachabilityManager(host: "http://www.baidu.com")
    }()
    
    var orientation: UIInterfaceOrientationMask = .portrait

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configBase()
        return true
    }
    
    func configBase() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        let defaults = UserDefaults.standard
        if defaults.value(forKey: String.sexTypeKey) == nil {
            defaults.set(1, forKey: String.sexTypeKey)
            defaults.synchronize()
        }
        
        reachabilityManager?.listener = { status in
            switch status {
            case .notReachable:
                print("网络不可用")
            case .unknown:
                print("未识别网络")
            case .reachable(.ethernetOrWiFi):
                print("当前网络为蜂窝数据")
            case .reachable(.wwan):
                print("当前网络为Wi-Fi")
            }
        }
        reachabilityManager?.startListening()
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return orientation
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

