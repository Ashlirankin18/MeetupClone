//
//  MapDisplayHeaderModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/13/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Represents the information needed to set up `EventHeaderView`
struct MapDisplayHeaderModel {
    
    /// The lattitude of the event
    let lattitude: Double?
    
    /// The longitude of the event
    let longitude: Double?
    
    /// The event's name
    let eventName: String
    
    /// The name of where the event is located
    let eventLocation: String?
}
