//
//  LoginViewController.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/16/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// Allows the user to authenticate their account with meetup.
class LoginViewController: UIViewController {
    
    var apiManager: MeetupAuthenticationHandler?
    
    @IBAction private func loginButtonPressed(_ sender: UIButton) {
        loadData()
    }
    
    private func loadData() {
        guard let apiManager = apiManager else {
            return }
        if !apiManager.hasOAuthToken() {
            apiManager.oAutTokenCompletionHandler = { error in
                if let error = error {
                    print(error)
                    self.apiManager?.startAuthorizationLogin()
                } else {
                   self.presentsUserInterfaceOnSuccess()
                }
            }
            apiManager.startAuthorizationLogin()
        }
    }
    
    private func presentsUserInterfaceOnSuccess() {
        DispatchQueue.main.async {
            guard let interfaceController = UIStoryboard(name: "MeetupInfoInterface", bundle: nil).instantiateViewController(withIdentifier: "MeetupInfoTabbarController") as? UITabBarController else {
                return }
            UIApplication.shared.keyWindow?.rootViewController = interfaceController
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        }
    }
}
