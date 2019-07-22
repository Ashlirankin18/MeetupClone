//
//  MeetupDataHandler.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

class MeetupDataHandler {
    var accessToken: String?
    
    typealias Handler = (Result<MeetupUserModel, AppError>) -> Void
    
    func retrieveUserData(accessToken: String, completionHandler: @escaping Handler) {
        let url = "https://api.meetup.com/2/member/self"
        
        NetworkHelper.shared.performDataTask(URLEndpoint: url, httpMethod: "GET", httpBody: nil,
                                             httpHeader: ("Bearer \(accessToken)", "Authorization")) { (results) in
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
