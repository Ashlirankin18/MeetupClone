//
//  Cancelable.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/5/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

protocol Cancelable: AnyObject {
    func cancelTask()
}
extension URLSessionDataTask: Cancelable {
    func cancelTask() {
        cancel()
    }
}
