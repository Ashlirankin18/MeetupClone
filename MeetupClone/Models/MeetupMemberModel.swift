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
    let id: Int
    let name: String
    let photo: MeetupPhotoModel?
}
