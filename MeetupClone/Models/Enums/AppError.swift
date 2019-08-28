//
//  AppError.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Errors that may occur during asynchronous call
///
/// - decodingError: Could not decode JSON
/// - encodingError: Could not encode model data
/// - badURL: URL that was given is bad(not valid)
/// - networkError: There is an error with the network
/// - badStatusCode: Status code returned from the request is >200
enum AppError: Error {
    
    case decodingError(String)
    case encodingError(String)
    case badURL(String)
    case networkError(Error)
    case badStatusCode(String)
}
