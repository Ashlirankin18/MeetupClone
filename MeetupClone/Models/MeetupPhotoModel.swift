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
    private var id: Int?
    
    /// another variation of the named property for id
    private var photoId: Int?
    
    /// The user's id which is determined on wethere and id or photoId was returned
    var userId: Int? {
        // Two id properties were needed because there were inconsistencies in the photoModel and a photoModel on the user object.
        return id == nil ? photoId : id
    }
    /// link to the photo
    let photoLink: URL
    
    private enum CodingKeys: String, CodingKey {
        case highresLink = "highres_link"
        case thumbLink = "thumb_link"
        case photoLink = "photo_link"
        case id
        case photoId = "photo_id"
    }
}
