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
    
    /// The URLName of the event 
    var urlName = "" {
        didSet {
            retrieveGroupEvents(urlName: urlName)
        }
    }
    
    /// The model representing the infoprmation a headerView need it be initilized
    var headerInformationModel: HeaderInformationModel?
    
    private let eventsDisplayTableViewControllerDataSource = EventsDisplayTableViewControllerDataSource()
    private let meetupDataHandler = MeetupDataHandler(networkHelper: NetworkHelper())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "EventDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EventDisplayCell")
        tableView.register(UINib(nibName: "EmptyStateTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EmptyStateCell")
        tableView.dataSource = eventsDisplayTableViewControllerDataSource
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        title = NSLocalizedString("Events", comment: "The events a group has")
        setupBarButtonItem()
    }
    
    private func setupBarButtonItem() {
        let backbutton = UIBarButtonItem(title: NSLocalizedString("Back", comment: "Tells the user to go back to the previous page."), style: .done, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backbutton
    }
    
    private func retrieveGroupEvents(urlName: String) {
        meetupDataHandler.retrieveEvents(with: urlName) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let events):
                self.eventsDisplayTableViewControllerDataSource.events = events
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func backButtonPressed() {
        dismiss(animated: true)
    }
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("GroupDisplayTableViewCell", owner: self, options: nil)?.first as? GroupDisplayTableViewCell
        guard let headerInformationModel = headerInformationModel else {
            return nil
        }
        headerView?.viewModel = GroupDisplayTableViewCell.ViewModel(groupName: headerInformationModel.name, groupImage: headerInformationModel.imageURL, members: nil, nextEventName: nil)
        return headerView
    }
}
