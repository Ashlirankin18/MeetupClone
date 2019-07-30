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
    let bio: String?
    let city: String?
    let country: String?
    let id: Int?
    let joined: Int
    let name: String
    let photo: MeetupPhotoModel?
}
