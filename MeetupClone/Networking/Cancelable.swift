//
//  Cancelable.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/5/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

/// Defines method which cancels a data task
protocol Cancelable: AnyObject {
    func cancelTask()
}

// MARK: - <#Cancelable#> Extension on the URLSessionDataTask, all the canceling of a datatask.

extension URLSessionDataTask: Cancelable {
    
    /// Cancels a datatask
    func cancelTask() {
        cancel()
    }
}
