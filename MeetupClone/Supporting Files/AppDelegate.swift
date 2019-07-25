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
    
    private let meetupAuthenticationHandler = MeetupAuthenticationHandler(userDefaults: UserDefaults.standard, networkHelper: NetworkHelper())
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let userLoggedIn = UserDefaults.standard.object(forKey: UserDefaultConstants.isLoggedIn.rawValue) as? Bool ?? false
        if userLoggedIn {
                guard let meetupUserInterface = UIStoryboard(name: "MeetupInfoInterface", bundle: nil).instantiateViewController(withIdentifier: "MeetupInfoTabbarController") as? UITabBarController else {
                    return false }
                window?.rootViewController = meetupUserInterface
                window?.makeKeyAndVisible()
        } else {
            UserDefaults.standard.set(false, forKey: UserDefaultConstants.isLoggedIn.rawValue)
            guard let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
                return false }
            loginViewController.meetupAuthenticationHandler = meetupAuthenticationHandler
            window?.rootViewController = loginViewController
            window?.makeKeyAndVisible()
        }
         return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        meetupAuthenticationHandler.processAuthorizationResponse(url: url)
        return true
    }
}
