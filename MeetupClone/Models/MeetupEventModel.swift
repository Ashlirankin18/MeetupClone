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
    
    /// Date the event was created.
    private let createdDate: Int
    
    /// Id of the event
    let eventId: String
    
    /// Name of the event
    let eventName: String
    
    /// Website link of the group
    let link: URL
    
    /// The events description
    let description: String
    
    /// Venue of the event
    let venue: MeetupVenueModel?
    
    private enum CodingKeys: String, CodingKey {
        case createdDate = "created"
        case eventId = "id"
        case eventName = "name"
        case link
        case description
        case venue
    }
}
