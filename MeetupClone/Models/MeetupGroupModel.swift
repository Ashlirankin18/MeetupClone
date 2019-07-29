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
    let name: String
    let link: URL
    let urlname: String?
    let created: Int
    let group_photo: Photo?
    let next_event: NextEvent?
    let description: String
}
