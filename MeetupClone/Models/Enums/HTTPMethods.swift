//
//  HTTPMethods.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Represents the different HTTPMethods that the application uses
///
/// - Post: Sending a POST Request to the server
/// - Get: Sending a GET Request to the server
enum HTTPMethods: String {
    case Post = "Post"
    case Get = "Get"
}
