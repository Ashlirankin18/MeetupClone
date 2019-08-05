//
//  MeetupPhotoModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Represents a Photo model
struct MeetupPhotoModel: Codable {
    
    /// high resoution link of an image
    let highresLink: URL
    
    /// thumbnail link of an image
    let thumbLink: URL
    
    /// id which represents an image
    let id: Int
    
    let photoLink: URL
    
    private enum CodingKeys: String, CodingKey {
        case highresLink = "highres_link"
        case thumbLink = "thumb_link"
        case photoLink = "photo_link"
        case id
    }
}
