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
    
    /// The event id
    let eventId: String
    
    /// The name of sn event
    let eventName: String
    
    /// The number of RSVP 
    let rsvpCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case eventId = "id"
        case eventName = "name"
        case rsvpCount = "yes_rsvp_count"
    }
}
