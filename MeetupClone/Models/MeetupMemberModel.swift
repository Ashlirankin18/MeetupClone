//
//  MeetupMemberModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Representation of Member of a Group
struct MeetupMemberModel: Codable {
    
    /// The member id
    let id: Int?
    
    /// The name of the member
    let name: String?
    
    /// The photo link the depict the member
    let photo: MeetupPhotoModel?
}
