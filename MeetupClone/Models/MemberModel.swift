//
//  MemberModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

struct Member: Codable {
    let id: Int
    let userName: String
    let photo: Photo
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case userName = "name"
        case photo = "photo"
    }
}
