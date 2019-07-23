//
//  MeetupAuthenticationHandler.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit
import SafariServices

class MeetupAuthenticationHandler {
    
    private var networkHelper: NetworkHelper
    
    private var userDefaults = UserDefaults.standard
    
    private let clientId = "pl35cjq6c05lqdjujqhb3tcggt"
    
    private let clientSecret = "aj1bqb98cjk521h8t4il2473sr"
    
    var OAuthToken: String?
    
    private let redirectURI = "deeplink://entry"
    
    private var oAutTokenCompletionHandler: ((Error?) -> Void)?
    
    init(userDefaults: UserDefaults, networkHelper: NetworkHelper) {
        self.networkHelper = networkHelper
        self.userDefaults = userDefaults
    }
    func hasOAuthToken() -> Bool {
        if let accessToken = userDefaults.object(forKey: "accessToken") as? String {
            self.OAuthToken = accessToken
            return true
        }
        return false
    }
    
    func startAuthorizationLogin() {
        let authPath = "https://secure.meetup.com/oauth2/authorize?client_id=\(clientId)&response_type=code&redirect_uri=\(redirectURI)"
        
        if let authURL = URL(string: authPath) {
            let defaults = userDefaults
            defaults.set(true, forKey: "loadingOAuthToken")
            UIApplication.shared.open(authURL, options: [:], completionHandler: nil)
        }
    }
    
    func processAuthorizationResponse(url: URL) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var code: String?
        if let qureyItems = components?.queryItems {
            for qureyItem in qureyItems {
                if qureyItem.name.lowercased() == "code" {
                    code = qureyItem.value
                    break
                }
            }
        }
        if let receivedCode = code {
            let getTokenPath = "https://secure.meetup.com/oauth2/access"
            let dataBody = "client_id=\(clientId)&client_secret=\(clientSecret)&grant_type=authorization_code&redirect_uri=\(redirectURI)&code=\(receivedCode)"
            let data = dataBody.data(using: .utf8)
            networkHelper.performDataTask(URLEndpoint: getTokenPath, httpMethod: "POST", httpBody: data, httpHeader: ("application/x-www-form-urlencoded", "Content-Type")) { (results) in
                switch results {
                case .failure(let error):
                    let defaults = UserDefaults.standard
                    defaults.set(false, forKey: "loadingOAuthToken")
                    print(error)
                case .success(let data):
                    do {
                        let success = try JSONDecoder().decode(AccessTokenSucessModel.self, from: data)
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(success.accessToken, forKey: "accessToken")
                        if self.hasOAuthToken() {
                            if let handler = self.oAutTokenCompletionHandler {
                                handler(nil)
                            }
                        }
                        let defaults = userDefaults
                        defaults.set(false, forKey: UserDefaultConstants .lodaingToken )
                    } catch {
                        do {
                            let failure = try JSONDecoder().decode(AccessTokenFailureModel.self, from: data)
                            print(failure)
                            let defaults = UserDefaults.standard
                            defaults.set(false, forKey: UserDefaultConstants .lodaingToken)
                        } catch {
                            let defaults = UserDefaults.standard
                            defaults.set(false, forKey: UserDefaultConstants .lodaingToken)
                            return
                        }
                    }
                }
            }
        }
    }
}
