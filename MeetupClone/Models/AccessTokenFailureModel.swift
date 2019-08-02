//
//  AccessTokenFailureModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// JSON response of a request for an access token.
struct AccessTokenFailureModel: Codable {
    
    /// Error returned from the server
    let error: String
}
