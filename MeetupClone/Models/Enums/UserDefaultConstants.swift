//
//  UserDefaultConstants.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Represents the UserDefaults constants of the application
enum UserDefaultConstants: String {
    /// stores if oAuth token methods are loading.
    case loadingToken = "loadingOAuthToken"
    /// stores the accessToken.
    case accessToken = "accessToken"
}
