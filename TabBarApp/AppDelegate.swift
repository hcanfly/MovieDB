//
//  AppDelegate.swift
//  TabBarApp
//
//  Created by Gary Hanson on 2/29/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import UIKit

extension MockData: DataProviding {}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var tabBarController: TabBarController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        tabBarController = TabBarController()
        window?.rootViewController = tabBarController

        window?.makeKeyAndVisible()
        
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .dark   // it just looks good this way
        }
        
        // this will set data provider globally. it can also be set internally as desired.
        // DataDownloader.dataProvider = MockData.shared
        return true
    }

    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
    }

}
