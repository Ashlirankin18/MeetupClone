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
    
    /// The model representing the information a headerView needs to be initilized
    var headerInformationModel: HeaderInformationModel? {
        didSet {
            title = headerInformationModel?.name
        }
    }

    private let eventsDisplayTableViewControllerDataSource = EventsDisplayTableViewControllerDataSource()
    
    private let meetupDataHandler = MeetupDataHandler(networkHelper: NetworkHelper())
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewProperties()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func configureTableViewProperties() {
        registerTableViewCells()
        tableView.dataSource = eventsDisplayTableViewControllerDataSource
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
         tableView.register(UINib(nibName: "EventDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EventDisplayCell")
    }

    private func retrieveGroupEvents(urlName: String) {
        meetupDataHandler.retrieveEvents(with: urlName) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let events):
                self.eventsDisplayTableViewControllerDataSource.events = events
                self.tableView.reloadData() 
            }
        }
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("GroupDisplayTableViewCell", owner: self, options: nil)?.first as? GroupDisplayTableViewCell
        guard let headerInformationModel = headerInformationModel else {
            return nil
        }
        headerView?.isHidden = false
        headerView?.viewModel = GroupDisplayTableViewCell.ViewModel(groupName: headerInformationModel.name, groupImage: headerInformationModel.imageURL, members: nil, nextEventName: nil, date: nil)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { 
        let detailedController = EventDetailedTableViewController(style: .grouped)
        let event = eventsDisplayTableViewControllerDataSource.events[indexPath.row]
        detailedController.meetupEventModel = event
        show(detailedController, sender: self)
    }
}
