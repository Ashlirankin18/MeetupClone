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
    /// Could not decode JSON
    case decodingError(String)
    /// Could not encode model data
    case encodingError(String)
    /// URL that was given is bad(not valid)
    case badURL(String)
    /// There is an error with the network
    case networkError(Error)
    /// Status code returned from the request is >200
    case badStatusCode(String)
}
