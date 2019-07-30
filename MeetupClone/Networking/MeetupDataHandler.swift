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
    typealias EventHandler = (Result<[MeetupEventModel], AppError>) -> Void
    
    ///  Represent the types that are expected to escape when the asynchrnous func completes.
    typealias RSVPHandler = (Result<[MeetupRSVPModel], AppError>) -> Void
    
    private typealias GenericHandler = (Result<Codable, AppError>) -> Void
    /// Retrieves the user data from the server.
    /// - Parameter accessToken: Access token that was returned from the server.
    /// - Parameter completionHandler: receives information (expected type) when asynchronous call completes.
    func retrieveUserData(completionHandler: @escaping UserHandler) {
        let urlString = "https://api.meetup.com/2/member/self"
        genericRetrievalFunc(urlString: urlString, decodingType: MeetupUserModel.self) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(.networkError(error)))
                return
            case .success(let object):
                guard let user = object as? MeetupUserModel else {
                    assertionFailure("Could not cast object as MeetupUserModel")
                    return }
                completionHandler(.success(user))
                return
            }
        }
    }
    
    /// Retrives groups from the server.
    ///
    /// - Parameters:
    ///   - zipCode: User provided zipcode. If there is not zipcode meetup provides similar groupos based on the location that was given when the account was created
    ///   - completionHandler: receives information (expected type) when asynchronous call completes.
    func retrieveMeetupGroups(zipCode: Int?, completionHandler: @escaping GroupHandler) {
        var urlString = ""
        urlString = zipCode == nil ? "https://api.meetup.com/find/groups?&sign=true&photo-host=public&page=20" : "https://api.meetup.com/find/groups?&sign=true&photo-host=public&zip=\(11429))&page=20"
        genericRetrievalFunc(urlString: urlString, decodingType: [MeetupGroupModel].self) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(.networkError(error)))
                return
            case .success(let object):
                guard let groups = object as? [MeetupGroupModel] else {
                    assertionFailure("Could not cast object as MeetupGroupModel")
                    return }
                completionHandler(.success(groups))
                return
            }
        }
    }
    
    /// Retrives events from the server based the groups urlname
    ///
    /// - Parameters:
    ///   - groupURLName: The URLName of the group
    ///   - completionHandler: receives information (expected type) when asynchronous call completes.
    func retrieveEvents(with groupURLName: String, completionHandler: @escaping EventHandler) {
        let urlString = "https://api.meetup.com/\(groupURLName)/events?&sign=true&photo-host=public&page=20"
        genericRetrievalFunc(urlString: urlString, decodingType: [MeetupEventModel].self) { (results) in
            
            switch results {
            case .failure(let error):
                completionHandler(.failure(.networkError(error)))
                return
            case .success(let object):
                guard let event = object as? [MeetupEventModel] else {
                    assertionFailure("Could not cast object as MeetupEventModel")
                    return
                }
                completionHandler(.success(event))
                return
            }
        }
    }
    
    /// Retrieves RSVP'S from the server based on the eventID and eventURLName
    ///
    /// - Parameters:
    ///   - eventId: The eventId of a chosen even.
    ///   - eventURLName: The event URL name.
    ///   - completionHandler: receives information (expected type) when asynchronous call completes
    func retrieveEventRSVP(eventId: Int, eventURLName: String, completionHandler: @escaping RSVPHandler ) {
        let urlString = "https://api.meetup.com/\(eventURLName)/events/\(eventId)/rsvps?&sign=true&photo-host=public"
        genericRetrievalFunc(urlString: urlString, decodingType: [MeetupRSVPModel].self) { (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(.networkError(error)))
                return
            case .success(let object):
                guard let rsvps = object as? [MeetupRSVPModel] else {
                    assertionFailure("Could not cast object as MeetupRSVPModel")
                    return }
                completionHandler(.success(rsvps))
                return
            }
        }
    }
    
    private func genericRetrievalFunc<T: Codable>(urlString: String, decodingType: T.Type, completion: @escaping GenericHandler) {
        guard let accessCode = accessToken else { assertionFailure("AccessToken maybe nil")
            return }
        let bearer = ("Bearer \(accessCode)", "Authorization")
        
        networkHelper.performDataTask(URLEndpoint: urlString, httpMethod: .Get, httpBody: nil, httpHeader: bearer) { (results) in
            switch results {
            case .failure(let error):
                completion(.failure(.networkError(error)))
                return
            case .success(let data):
                do {
                    let object = try JSONDecoder().decode(decodingType, from: data)
                    completion(.success(object))
                    return
                } catch {
                    completion(.failure(.decodingError("Could not decode type")))
                    return
                }
            }
        }
    }
}
