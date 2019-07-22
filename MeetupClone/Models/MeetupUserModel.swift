//
//  MeetupUserModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

struct MeetupUserModel: Codable{
    let bio: String?
    let city: String?
    let country: String?
    let id: Int?
    let joinedDate: Int
    let userName: String
    let photo: Photo?
    
    private enum CodingKeys: String, CodingKey {
        case bio = "bio"
        case city = "city"
        case country = "country"
        case id = "id"
        case joinedDate = "joined"
        case userName = "name"
        case photo = "photo"
        
    }
}
struct Photo: Codable {
    let baseURL: URL?
    let highresLink: URL?
    let thumbnailLink: URL?
    
    private enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case highresLink = "highres_link"
        case thumbnailLink = "thumb_link"
    }
}

