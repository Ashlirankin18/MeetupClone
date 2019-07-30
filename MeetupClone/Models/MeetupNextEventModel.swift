//
//  MeetupNextEventModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/29/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Represents a Next Event Model
struct MeetupNextEventModel: Codable {
    let id: String
    let name: String
    let yes_rsvp_count: Int
}
