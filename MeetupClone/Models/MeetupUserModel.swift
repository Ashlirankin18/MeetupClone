//
//  MeetupUserModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Model of Application user
struct MeetupUserModel: Codable {
    
    /// The user's bio
    let bio: String?
    
    /// The city the user is located in
    let city: String?
    
    /// The country the user is located
    let country: String?
    
    /// the user's id
    let id: Int?
    
    /// the date the user joined meetup
    let joined: Date
    
    /// The user's name
    let name: String
    
    /// The user's image on file
    let photo: MeetupPhotoModel?
}
