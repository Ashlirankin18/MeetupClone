//
//  AppError.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

enum AppError: Error {
    case decodingError(String)
    case encodingError(String)
    case badURL(String)
    case networkError(Error)
    case badStatusCode(String)
}
