//
//  MeetupAuthenticationHandler.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit
import SafariServices

/// Handles the authorization and authentication of the user with the meetup API.
class MeetupAuthenticationHandler {
    
    private let networkHelper: NetworkHelper
    
    private let userDefaults: UserDefaults
    
    private let clientId = "pl35cjq6c05lqdjujqhb3tcggt"
    
    private let clientSecret = "aj1bqb98cjk521h8t4il2473sr"
    
    private let redirectURI = "deeplink://entry"
    
    private var oAutTokenCompletionHandler: ((Error?) -> Void)?
    
    /// Initializes UserDefaults and Network Helper which preforms network request.
    init(userDefaults: UserDefaults, networkHelper: NetworkHelper) {
        self.networkHelper = networkHelper
        self.userDefaults = userDefaults
    }
    
    /// Checks userDefaults for an accessToken returns a bool value based on the findings.
    func hasOAuthToken() -> Bool {
        
        if (userDefaults.object(forKey: UserDefaultConstants.accessToken.rawValue) as? String) != nil {
            return true
        }
        return false
    }
    
    /// Uses the API's authorization URL which takes the user to a page where they give authorization on the app.
    func startAuthorizationLogin() {
        
        /// Used to get an access code from the server.
        let authPath = "https://secure.meetup.com/oauth2/authorize?client_id=\(clientId)&response_type=code&redirect_uri=\(redirectURI)"
        
        if let authURL = URL(string: authPath) {
            let defaults = userDefaults
            defaults.set(true, forKey: UserDefaultConstants .lodaingToken.rawValue)
            UIApplication.shared.open(authURL, options: [:], completionHandler: nil)
        }
    }
    
    /// Analyzes the url  returned from the browser, then extracts the authorization code
    /// - Parameter url: Returned from the browser.
    func processAuthorizationResponse(url: URL) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        let code = components?.queryItems?.first { $0.name.lowercased() == "code" }
        
        if let receivedCode = code {
            retrievesAccessToken(from: receivedCode)
        }
    }
    
    /// Takes accessToken that was extracted from processAuthorizationResponse and requests an accesToken from the server.
    /// - Parameter accessCode: Code extracted from the URL returned from the URL.
    private func retrievesAccessToken(from accessCode: URLQueryItem) {
        let getTokenPath = "https://secure.meetup.com/oauth2/access"
        
        /// Converted to data that will be the Body of the request.
        let dataBody = "client_id=\(clientId)&client_secret=\(clientSecret)&grant_type=authorization_code&redirect_uri=\(redirectURI)&code=\(accessCode)"
        
        let data = dataBody.data(using: .utf8)
        
        networkHelper.performDataTask(URLEndpoint: getTokenPath, httpMethod: .Post, httpBody: data, httpHeader: ("application/x-www-form-urlencoded", "Content-Type")) { (results) in
            switch results {
                
            case .failure(let error):
                self.userDefaults.set(false, forKey: UserDefaultConstants .lodaingToken.rawValue)
                print(error)
                
            case .success(let data):
                
                do {
                    let success = try JSONDecoder().decode(AccessTokenSucessModel.self, from: data)
                    
                    self.userDefaults.set(success.accessToken, forKey: UserDefaultConstants.accessToken.rawValue)
                    if self.hasOAuthToken() {
                        if let handler = self.oAutTokenCompletionHandler {
                            handler(nil)
                        }
                    }
                    self.userDefaults.set(false, forKey: UserDefaultConstants .lodaingToken.rawValue )
                } catch {
                    
                    do {
                        let failure = try JSONDecoder().decode(AccessTokenFailureModel.self, from: data)
                        print(failure)
                        self.userDefaults.set(false, forKey: UserDefaultConstants .lodaingToken.rawValue)
                    } catch {
                        self.userDefaults.set(false, forKey: UserDefaultConstants .lodaingToken.rawValue)
                        return
                    }
                }
            }
        }
    }
}
