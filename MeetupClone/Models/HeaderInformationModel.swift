//
//  HeaderInformationModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/7/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Represents the information needed to see up a HeaderView
struct HeaderInformationModel {
    
    /// The URL of an image that will be displayed on the header view.
    let imageURL: URL?
    
    /// The name of the group.
    let name: String
}
