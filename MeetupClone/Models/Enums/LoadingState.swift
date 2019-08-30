//
//  LoadingState.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/27/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// The state of loading data
enum LoadingState {
    ///  isLoading: Represents the data is loading.
    case isLoading
    ///  isFinishLoading: Used when data has returned and network request has been completed.
    case isFinishLoading
}
