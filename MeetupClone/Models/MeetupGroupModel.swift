//
//  MeetupGroupModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Represents a MeetupGroup model.
struct MeetupGroupModel: Codable {
    let id: String
    let groupName: String
    let link: URL
    let description: String
    let createdDate: Int
    let latitude: Double
    let longitude: Double
    let photo: Photo
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case groupName = "name"
        case link = "link"
        case description = "description"
        case createdDate = "created"
        case latitude = "lat"
        case longitude = "lon"
        case photo = "key_photo"
    }
}
