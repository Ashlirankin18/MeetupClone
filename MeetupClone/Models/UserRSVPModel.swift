//
//  UserRSVPModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

struct UserRSVPModel: Codable {
    let createdDate: Int
    let member: Member
    let response: String
    
    private enum CodingKeys: String, CodingKey {
        case createdDate = "created"
        case member = "member"
        case response = "response"
    }
}
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
