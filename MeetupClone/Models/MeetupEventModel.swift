//
//  MeetupEventModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/30/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Model of a MeetupEvent
struct MeetupEventModel: Codable {
    let created: Int
    let id: String
    let name: String
    let link: String
    let description: String
    let venue: MeetupVenueModel?
}
