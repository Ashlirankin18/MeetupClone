//
//  EventDetailedTableViewController.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/8/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// `UITableViewController` subclass that will display MeetUpEvent location details and the persons who have rsv'p to an event
final class EventDetailedTableViewController: UITableViewController {
   let eventDetailedControllerDataSource = EventDetailedControllerDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MeetupMemberDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MemberCell")
        tableView.dataSource = eventDetailedControllerDataSource
       tableView.rowHeight = 100
    }
}
