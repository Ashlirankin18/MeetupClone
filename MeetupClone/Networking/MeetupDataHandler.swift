//
//  MeetupDataHandler.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Handles the methods that will request data from  the server.

class MeetupDataHandler {
    
    private var networkHelper: NetworkHelper
    var meetupAuthenticatiorHandler = MeetupAuthenticationHandler(userDefaults: UserDefaults.standard, networkHelper: NetworkHelper())
    /// Initializes the class with networkHelper.
    init(networkHelper: NetworkHelper) {
        self.networkHelper = networkHelper
    }
    
    typealias UserHandler = (Result<MeetupUserModel, AppError>) -> Void
    typealias GroupHandler = (Result<[MeetupGroupModel], AppError>) -> Void
    
    /// Retrieves the user data from the server.
    /// - Parameter accessToken: Access token that was returned from the server.
    /// - Parameter completionHandler: receives information (expected type) when asynchronous call completes.
    func retrieveUserData(completionHandler: @escaping UserHandler) {
        let accessToken = meetupAuthenticatiorHandler.accessToken
        let bearer = ("Bearer \(accessToken)", "Authorization")
        let urlString = "https://api.meetup.com/2/member/self"
        networkHelper.performDataTask(URLEndpoint: urlString, httpMethod: .Post, httpBody: nil, httpHeader: bearer) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(.networkError(error)))
                return
            case .success(let data):
                do {
                    let user = try JSONDecoder().decode(MeetupUserModel.self, from: data)
                    completionHandler(.success(user))
                    return
                } catch {
                    completionHandler(.failure(.decodingError("Could not decode UserModel from data")))
                    return
                }
            }
        }
    }
    
    func retrieveMeetupGroups(zipCode: Int?, completionHandler: @escaping GroupHandler) {
        let accessToken = UserDefaults.standard.object(forKey: UserDefaultConstants.accessToken.rawValue) ?? ""
        var urlString = ""
        urlString = zipCode == nil ? "https://api.meetup.com/find/groups?&sign=true&photo-host=public&page=20" : "https://api.meetup.com/find/groups?&sign=true&photo-host=public&zip=\(11429)&page=20"
        networkHelper.performDataTask(URLEndpoint: urlString, httpMethod: .Get, httpBody: nil, httpHeader: ("Bearer \(accessToken)", "Authorization")) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(.networkError(error)))
                return
            case .success(let data):
                do {
                   let groups = try JSONDecoder().decode([MeetupGroupModel].self, from: data)
                 completionHandler(.success(groups))
                    return
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
