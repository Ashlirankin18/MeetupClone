//
//  AccessTokenSuccessModel.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/22/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// JSON response of a request for an access token.
struct AccessTokenSucessModel: Codable {
    
    /// Access token provided by the server
    let accessToken: String
    
    /// Type of toke provided
    let tokenType: String
    
    ///  Value representing the amount of time it takes for a token to expire
    let expiresIn: TimeInterval
    
    /// Refresh token 
    let refreshToken: String
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
    }
}
