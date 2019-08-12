//
//  MeetupVenueModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/30/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Model representing a venue where an event will be held.
struct MeetupVenueModel: Codable {
    
    /// The id of the venue
    let eventId: Int
    
    /// The venue name
    let venueName: String
    
    /// the location's lattitude
    let lattitude: Double
    
    /// the location's longitude
    let longitude: Double
    
    /// The city that the event will be held
    let city: String
    /// The state that the event will be held
    let state: String?
    
    private enum CodingKeys: String, CodingKey {
        case eventId = "id"
        case venueName = "name"
        case lattitude = "lat"
        case longitude = "lon"
        case city
        case state
    }
}
