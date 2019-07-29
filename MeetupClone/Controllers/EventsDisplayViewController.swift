//
//  EventsDisplayViewController.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/29/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit
/// Display a list of events after the user taps on a group.
class EventsDisplayViewController: UIViewController {
    
    private let meetUpDataHandler = MeetupDataHandler(networkHelper: NetworkHelper())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveEvents()
    }
    
    private func retrieveEvents() {
        meetUpDataHandler.retrieveEvents(with: "Build-with-Code-New-York") { (results) in
                switch results {
                case .failure(let error):
                    print(error)
                case .success(let events):
                    print(events)
                }
        }
    }
}
