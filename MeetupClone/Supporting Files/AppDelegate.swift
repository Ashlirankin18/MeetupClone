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
    
    private lazy var meetupAuthenticationHandler = MeetupAuthenticationHandler(preferences: self.preferences, networkHelper: NetworkHelper())
    private let preferences = Preferences(userDefaults: UserDefaults.standard)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if preferences.isFirstLaunch {
            guard let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
                return false }
            loginViewController.meetupAuthenticationHandler = meetupAuthenticationHandler
            window?.rootViewController = loginViewController
            window?.makeKeyAndVisible()
        } else {

            guard let meetupUserInterface = UIStoryboard(name: "MeetupInfoInterface", bundle: nil).instantiateViewController(withIdentifier: "MeetupInfoTabbarController") as? UITabBarController else {
                return false
            }
            window?.rootViewController = meetupUserInterface
            window?.makeKeyAndVisible()        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        meetupAuthenticationHandler.processAuthorizationResponse(url: url)
        return true
    }
}
