//
//  FavoriteEventsModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/13/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Represents a Favorite event
struct FavoriteEventsModel: Codable {
    
    /// The lattitude of the event
    let lattitude: Double?
    
    /// The longitude of the event
    let longitude: Double?
    
    /// The name of the event
    let eventName: String
    
    /// The name of the city where the event is being held
    let eventCity: String
    
    /// The group's URL Name
    let urlName: String
    
    /// The event's id
    let eventId: String
   
    /// Indicates wether a event was favorited of not.
    let isFavorited: Bool
    
    /// The event's description
    let description: String?
    
    /// The number of the person who have rsvp'd
    let rsvpCount: Int
}
