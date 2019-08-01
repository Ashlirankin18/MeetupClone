//
//  Int+Ext.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/1/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

extension Int {
    func formatDateToMilliseconds() -> Date {
        let date = Date(timeIntervalSince1970: Double(self / 1000))
        return  date
    }
}
