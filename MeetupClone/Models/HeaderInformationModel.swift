//
//  HeaderInformationModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/7/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

struct HeaderInformationModel {
    let imageURL: URL
    let name: String
}

struct MapDisplayHeaderModel {
    let lattitude: Double?
    let longitude: Double?
    let eventName: String
    let eventLocation: String?
}
