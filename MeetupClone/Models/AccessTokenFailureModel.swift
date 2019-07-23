//
//  AccessTokenFailureModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// JSON response of a requesrt for an access token.
struct AccessTokenFailureModel: Codable {
    let error: String
}
