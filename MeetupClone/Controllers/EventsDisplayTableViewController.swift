//
//  EventsDisplayTableViewController.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/1/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// `UITableViewController` which will display a list of events
final class EventsDisplayTableViewController: UITableViewController {

    private var items: [Codable] = []
    private var headerView: UIView?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initilizes the tableview controller
    ///
    /// - Parameters:
    ///   - items: An array of items that will be displayed on the tableView cells
    ///   - headerView: The header view which will display information. If there is a view it will be displayed if not the value will be nil
    init(items: [MeetupGroupModel], headerView: UIView?) {
        super.init(nibName: nil, bundle: nil)
        self.items = items
        self.headerView = headerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "EventDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EventDisplayCell")
    }
}
