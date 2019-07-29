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
    private var meetupAuthenticatiorHandler = MeetupAuthenticationHandler(userDefaults: UserDefaults.standard, networkHelper: NetworkHelper())
    private let accessToken = UserDefaults.standard.object(forKey: UserDefaultConstants.accessToken.rawValue) as? String
    /// Initializes the class with networkHelper.
    init(networkHelper: NetworkHelper) {
        self.networkHelper = networkHelper
    }
    
    /// Represent the types that are expected to escape when the asynchrnous func completes.
    typealias UserHandler = (Result<MeetupUserModel, AppError>) -> Void
    
    /// Represent the types that are expected to escape when the asynchrnous func completes.
    typealias GroupHandler = (Result<[MeetupGroupModel], AppError>) -> Void
   
    /// Represent the types that are expected to escape when the asynchrnous func completes.
    typealias EventHandler = (Result<[MeetupGroupModel], AppError>) -> Void
    
    /// Retrieves the user data from the server.
    /// - Parameter accessToken: Access token that was returned from the server.
    /// - Parameter completionHandler: receives information (expected type) when asynchronous call completes.
    func retrieveUserData(completionHandler: @escaping UserHandler) {
        let bearer = ("Bearer \(String(describing: accessToken))", "Authorization")
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
    
    /// Retrives groups from the server.
    ///
    /// - Parameters:
    ///   - zipCode: User provided zipcode. If there is not zipcode meetup provides similar groupos based on the location that was given when the account was created
    ///   - completionHandler: receives information (expected type) when asynchronous call completes.
    func retrieveMeetupGroups(zipCode: Int?, completionHandler: @escaping GroupHandler) {
        guard let accessCode = accessToken else {assertionFailure("AccessToken maybe nil")
            return }
        var urlString = ""
        urlString = zipCode == nil ? "https://api.meetup.com/find/groups?&sign=true&photo-host=public&page=20" : "https://api.meetup.com/find/groups?&sign=true&photo-host=public&zip=\(11429))&page=20"
        networkHelper.performDataTask(URLEndpoint: urlString, httpMethod: .Get, httpBody: nil, httpHeader: ("Bearer \(accessCode)", "Authorization")) { (results) in
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
    
    /// Retrives events from the server based the groups urlname
    ///
    /// - Parameters:
    ///   - groupURLName: The URLName of the group
    ///   - completionHandler: receives information (expected type) when asynchronous call completes.
    func retrieveEvents(with groupURLName: String, completionHandler: @escaping EventHandler) {
        guard let accessCode = accessToken else {assertionFailure("AccessToken maybe nil")
            return }
        let urlString = "https://api.meetup.com/\(groupURLName)/events?&sign=true&photo-host=public&page=20"
        networkHelper.performDataTask(URLEndpoint: urlString, httpMethod: .Get, httpBody: nil, httpHeader: ("Bearer \(accessCode)", "Authorization")) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(.networkError(error)))
                return
            case .success(let data):
                do {
                    let events = try JSONDecoder().decode([MeetupGroupModel].self, from: data)
                    print(events)
                } catch {
                    print(error.localizedDescription)
                    return
                }
            }
        }
    }
}
