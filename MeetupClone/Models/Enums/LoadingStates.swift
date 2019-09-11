//
//  LoadingStates.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/27/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// The state of loading data
///
/// - isLoading: Data is loading. Is seen when there is an acticity indicator.
/// - isFinishLoading: Used when data has returned and network request has been completed.
enum LoadingStates {
    case isLoading
    case isFinishLoading
}
