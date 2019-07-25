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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
<<<<<<< HEAD
        if !apiManager.hasOAuthToken() {
            guard let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
                return false }
            loginViewController.apiManager = apiManager
            window?.rootViewController = loginViewController
            window?.makeKeyAndVisible()
        } else {
            guard let meetupUserInterface = UIStoryboard(name: "MeetupInfoInterface", bundle: nil).instantiateViewController(withIdentifier: "MeetupInfoTabbarController") as? UITabBarController else {
                return false }
            window?.rootViewController = meetupUserInterface
            window?.makeKeyAndVisible()
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        apiManager.processAuthorizationResponse(url: url)
=======
       
>>>>>>> parent of 3c3034e... Added code to the a--delegate which check for a OAuthToken. Based on this result the root viewController of the window is set
        return true
    }
}
