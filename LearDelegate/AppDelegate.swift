//
//  AppDelegate.swift
//  LearDelegate
//
//  Created by Neal on 2020/1/13.
//  Copyright © 2020 neal812220. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let delegateVC = ViewController()
        
        window?.rootViewController = delegateVC
        
        window?.backgroundColor = .black
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    

}

