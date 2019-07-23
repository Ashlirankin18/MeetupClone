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
    
    /// Initializes the class with networkHelper.
    init(networkHelper: NetworkHelper) {
        self.networkHelper = networkHelper
    }
    
    typealias Handler = (Result<MeetupUserModel, AppError>) -> Void
    
    /// Retrieves the user data from the server.
    /// - Parameter accessToken: Access token that was returned from the server.
    /// - Parameter completionHandler: receives informationt(expected type) when asynchronous call completes.
    func retrieveUserData(accessToken: String, completionHandler: @escaping Handler) {
        
        let url = "https://api.meetup.com/2/member/self"
        
        networkHelper.performDataTask(URLEndpoint: url, httpMethod: .Post, httpBody: nil, httpHeader: ("Bearer \(accessToken)", "Authorization")) { (results) in
            switch results {
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    let user = try JSONDecoder().decode(MeetupUserModel.self, from: data)
                    completionHandler(.success(user))
                } catch {
                    completionHandler(.failure(.decodingError("Could not decode UserModel from data")))
                }
            }
        }
    }
}
