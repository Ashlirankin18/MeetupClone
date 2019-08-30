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
    ///  isLoggedIn: stores if oAuth token methods are loading.
    case isLoggedIn = "isLoggedIn"
    ///  accessToken: stores the accessToken.
    case accessToken = "accessToken"
    ///  searchText: stores the search text the user entered
    case searchText = "searchText"
    ///  zipCode: stores the zipcode the user entered
    case zipCode = "zipCode"
}
