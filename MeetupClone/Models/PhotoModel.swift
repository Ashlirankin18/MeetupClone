//
//  PhotoModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

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
