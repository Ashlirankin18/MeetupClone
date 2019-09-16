//
//  Preferences.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 9/13/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Holds the methods and properties related to user and application preferences.
final class Preferences {
    
    private var userDefaults: UserDefaults
    
    /// State which monitors the applications first launch.
    var isFirstLaunch: Bool {
        get {
            return userDefaults.object(forKey: UserDefaultConstants.isFirstLaunch.rawValue) as? Bool ?? true
        } set {
            userDefaults.set(newValue, forKey: UserDefaultConstants.isFirstLaunch.rawValue)
        }
    }
    
    /// Text used to search for a Meetup group.
    var serarchText: String {
        get {
            return userDefaults.object(forKey: UserDefaultConstants.searchText.rawValue) as? String ?? ""
        } set {
            userDefaults.set(newValue, forKey: UserDefaultConstants.searchText.rawValue)
        }
    }
    
    /// Zip Code representing the area the user would like groups in.
    var zipCode: String {
        get {
           return userDefaults.object(forKey: UserDefaultConstants.zipCode.rawValue) as? String ?? NSLocalizedString("Zip Code", comment: "Represents a zip code")
        } set {
            userDefaults.set(newValue, forKey: UserDefaultConstants.zipCode.rawValue)
        }
    }
    
    var accessToken: String? {
        get {
          return userDefaults.object(forKey: UserDefaultConstants.accessToken.rawValue) as? String
        } set {
            userDefaults.set(newValue, forKey: UserDefaultConstants.accessToken.rawValue)
        }
    }
    var isLoggedIn: Bool {
        get {
        return userDefaults.bool(forKey: UserDefaultConstants.isLoggedIn.rawValue)
        } set {
            userDefaults.set(newValue, forKey: UserDefaultConstants.isLoggedIn.rawValue)
        }
    }
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
}
