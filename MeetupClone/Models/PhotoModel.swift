//
//  PhotoModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Represents a Photo model
struct Photo: Codable {
    let highres_link: String
    let thumb_link: String
    let id: Int
}
