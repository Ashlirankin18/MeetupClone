//
//  Venue.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/30/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Model representing a venue where an event will be held.
struct Venue: Codable {
    let id: Int
    let name: String
    let lat: Double
    let lon: Double
}
