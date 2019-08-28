//
//  UserDefaultConstants.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Represents the UserDefaults constants of the application
///
/// - isLoggedIn: stores if oAuth token methods are loading.
/// - accessToken: stores the accessToken.
/// - searchText: stores the search text the user entered
/// - zipCode: stores the zipcode the user entered
enum UserDefaultConstants: String {
    
    case isLoggedIn = "isLoggedIn"
    case accessToken = "accessToken"
    case searchText = "searchText"
    case zipCode = "zipCode"
}
