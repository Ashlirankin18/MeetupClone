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
    
    /// Id of the event
    let eventId: String
    
    /// Name of the event
    let eventName: String
    
    /// Website link of the group
    let link: URL
    
    /// A description of the event
    let description: String?
    
    /// Venue of the event
    let venue: MeetupVenueModel?
    
    /// Number of people who responded yes to the event
    let yesRSVPCount: Int
    
    /// The group that is hosting the event.
    let group: MeetupGroupModel
    
    private enum CodingKeys: String, CodingKey {
        case eventId = "id"
        case eventName = "name"
        case link
        case venue
        case description
        case yesRSVPCount = "yes_rsvp_count"
        case group
    }
}
