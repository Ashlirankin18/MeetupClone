//
//  AppError.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Errors that may occur during asynchronous call
enum AppError: Error {
    ///  decodingError: Could not decode JSON
    case decodingError(String)
    ///  encodingError: Could not encode model data
    case encodingError(String)
    ///  badURL: URL that was given is bad(not valid)
    case badURL(String)
    ///  networkError: There is an error with the network
    case networkError(Error)
    ///  badStatusCode: Status code returned from the request is >200
    case badStatusCode(String)
}
