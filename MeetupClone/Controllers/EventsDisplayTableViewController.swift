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
    var headerInformationModel: HeaderInformationModel? {
        didSet {
            title = headerInformationModel?.name
        }
    }
    
    private var activityIndicatorView = ActivityIndicatorView()
    
    private let eventsDisplayTableViewControllerDataSource = EventsDisplayTableViewControllerDataSource()
    
    private let meetupDataHandler = MeetupDataHandler(networkHelper: NetworkHelper())
    
    private var isAnimating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewProperties()
        navigationItem.largeTitleDisplayMode = .never
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicatorView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.height)
        showActivityIndicator()
    }
    
    private func showActivityIndicator() {
        tableView.backgroundView = activityIndicatorView
        activityIndicatorView.indicatorStartAnimating()
        isAnimating = true
    }
    private func hideActivityIndicator() {
        tableView.backgroundView = nil
        activityIndicatorView.indicatorStopAnimating()
         isAnimating = false
    }
    private func configureTableViewProperties() {
        registerTableViewCells()
        tableView.dataSource = eventsDisplayTableViewControllerDataSource
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
    }
    private func registerTableViewCells() {
        tableView.register(UINib(nibName: "EventDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EventDisplayCell")
        tableView.register(UINib(nibName: "EmptyStateTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EmptyStateCell")
    }
    private func retrieveGroupEvents(urlName: String) {
        meetupDataHandler.retrieveEvents(with: urlName) { [weak self] result in
            
            switch result {
            case .failure(let error):
                print(error)
            case .success(let events):
               
                guard let self = self else {
                    return
                }
                 self.hideActivityIndicator()
                self.eventsDisplayTableViewControllerDataSource.events = events
                self.tableView.reloadData()
                self.hideActivityIndicator()
            }
        }
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("GroupDisplayTableViewCell", owner: self, options: nil)?.first as? GroupDisplayTableViewCell
        guard let headerInformationModel = headerInformationModel else {
            return nil
        }

        if activityIndicatorView.isAnimating {
            headerView?.isHidden = true
        } else {
            headerView?.isHidden = false
            headerView?.viewModel = GroupDisplayTableViewCell.ViewModel(groupName: headerInformationModel.name, groupImage: headerInformationModel.imageURL, members: nil, nextEventName: nil, date: nil)
        }
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { 
        let detailedController = EventDetailedTableViewController(style: .grouped)
        let event = eventsDisplayTableViewControllerDataSource.events[indexPath.row]
        detailedController.meetupEventModel = event
        show(detailedController, sender: self)
    }
}
