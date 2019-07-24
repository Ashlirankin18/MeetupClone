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
    
    /// Manages the authentication flow
    var apiManager: MeetupAuthenticationHandler?
    
    private var alertController: UIAlertController?
    
    @IBAction private func loginButtonPressed(_ sender: UIButton) {
        initiateLoginFlow()
    }
    
    private func setUpAlertController(title: String, message: String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let tryAgainAction = UIAlertAction(title: "TryAgain", style: .default) { _ in
            self.apiManager?.startAuthorizationLogin()
        }
        alertController?.addAction(tryAgainAction)
    }
    
    private func initiateLoginFlow() {
        guard let apiManager = apiManager else {
            return }
        if !apiManager.hasOAuthToken() {
            apiManager.oAutTokenCompletionHandler = { error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.setUpAlertController(title: "", message: "Could not authenticate you account try again \(error.localizedDescription)")
                    }
                    
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
            interfaceController.selectedViewController = interfaceController.viewControllers?[2]
            UIApplication.shared.keyWindow?.rootViewController = interfaceController
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        }
    }
}
