//
//  AppDelegate.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/16/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let apiManager = MeetupAuthenticationHandler(userDefaults: UserDefaults.standard, networkHelper: NetworkHelper())
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        apiManager.processAuthorizationResponse(url: url)
        return true
    }
}
