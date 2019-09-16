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
    
    private let preferences: Preferences
    
    private let clientId = "v72nhfu0f9khu3i2bf1t6h87md"
    
    private let clientSecret = "kh32q1hlal6jvc8j3tdv1809rp"
    
    private let redirectURI = "groupviewerentryurl://entry"
    
    var oAuthTokenCompletionHandler: ((Error?) -> Void)?
    
    /// Initializes UserDefaults and Network Helper which performs network request.
    init(preferences: Preferences, networkHelper: NetworkHelper) {
        self.networkHelper = networkHelper
        self.preferences = preferences
    }
    
    /// Checks userDefaults for an accessToken returns a bool value based on the findings.
    func hasOAuthToken() -> Bool {
        return preferences.accessToken != nil
    }
    
    /// Uses the API's authorization URL which takes the user to a page where they give authorization on the app.
    func startAuthorizationLogin() {
        
        /// Used to get an access code from the server.
        let authPath = "https://secure.meetup.com/oauth2/authorize?client_id=\(clientId)&response_type=code&redirect_uri=\(redirectURI)"
        
        if let authURL = URL(string: authPath) {
            UIApplication.shared.open(authURL, options: [:], completionHandler: nil)
        }
    }
    
    /// Analyzes the url  returned from the browser, then extracts the authorization code
    /// - Parameter url: Returned from the browser.
    func processAuthorizationResponse(url: URL) {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        let code = components?.queryItems?.first { $0.name.lowercased() == "code" }
        
        if let receivedCode = code?.value {
            retrievesAccessToken(from: receivedCode)
        } else {
            assertionFailure("could not retrieve authorization code")
        }
    }
    
    /// Takes accessToken that was extracted from processAuthorizationResponse and requests an accessToken from the server.
    /// - Parameter accessCode: Code extracted from the URL returned from the URL.
    
    @discardableResult private func retrievesAccessToken(from accessCode: String) -> Cancelable? {
        let getTokenPath = "https://secure.meetup.com/oauth2/access"
        
        /// Converted to data that will be the Body of the request.
        let dataBody = "client_id=\(clientId)&client_secret=\(clientSecret)&grant_type=authorization_code&redirect_uri=\(redirectURI)&code=\(accessCode)"
        
        let data = dataBody.data(using: .utf8)
        let dataTask = networkHelper.performDataTask(URLEndpoint: getTokenPath, httpMethod: .Post, httpBody: data, httpHeader: ("application/x-www-form-urlencoded", "Content-Type")) { (results) in
            switch results {
            case .failure(let error):
                print(error)
                self.preferences.isLoggedIn = false
                return
            case .success(let data):
                
                do {
                    let success = try JSONDecoder().decode(AccessTokenSucessModel.self, from: data)
                    self.preferences.accessToken = success.accessToken
                    if self.hasOAuthToken() {
                        if let handler = self.oAuthTokenCompletionHandler {
                            handler(nil)
                        }
                    }
                    self.preferences.isLoggedIn = true
                    return
                } catch {
                    do {
                        let failure = try JSONDecoder().decode(AccessTokenFailureModel.self, from: data)
                        print(failure)
                        self.preferences.isLoggedIn = false
                        return
                    } catch {
                        return
                    }
                }
            }
        }
        return dataTask
    }
}
