//
//  MeetupPhotoModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Represents a Photo model
struct MeetupPhotoModel: Decodable {
    
    /// high resoution link of an image
    let highresLink: URL
    
    /// thumbnail link of an image
    let thumbLink: URL
    
    /// id which represents an image
    private var id: Int?
    
    private var photoId: Int?
    
    var userId: Int? {
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
    
    init(decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = container.contains(.id) ? try container.decode(Int.self, forKey: .id) : try container.decode(Int.self, forKey: .photoId)
        highresLink = try container.decode(URL.self, forKey: .highresLink)
        thumbLink = try container.decode(URL.self, forKey: .thumbLink)
        photoLink = try container.decode(URL.self, forKey: .photoLink)
    }
}
extension MeetupPhotoModel: Encodable {
}
