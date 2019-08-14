//
//  MeetupRSVPModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Represents a RSVP model
struct MeetupRSVPModel: Codable {
    
    /// The member who RSVP
    let member: MeetupMemberModel
    
    /// The member's response
    let response: String?
}
