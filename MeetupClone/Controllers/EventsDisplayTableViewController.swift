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
    
    var urlName = "" {
        didSet {
            retrieveGroupEvents(urlName: urlName)
        }
    }
    
    private let eventsDisplayTableViewControllerDataSource = EventsDisplayTableViewControllerDataSource()
    private let meetupDataHandler = MeetupDataHandler(networkHelper: NetworkHelper())

    /// Initilizes the tableview controller
    ///
    /// - Parameters:
    ///   - items: An array of items that will be displayed on the tableView cells
    ///   - headerView: The header view which will display information. If there is a view it will be displayed if not the value will be nil
    init(urlName: String) {
        super.init(nibName: nil, bundle: nil)
        self.urlName = urlName
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "EventDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EventDisplayCell")
        tableView.dataSource = eventsDisplayTableViewControllerDataSource
    }
    
    func retrieveGroupEvents(urlName: String) {
        meetupDataHandler.retrieveEvents(with: urlName) { (results) in
            switch results {
            case .failure(let error):
                print(error)
            case .success(let events):
                self.eventsDisplayTableViewControllerDataSource.items = events
                self.tableView.reloadData()
            }
        }
    }
}
