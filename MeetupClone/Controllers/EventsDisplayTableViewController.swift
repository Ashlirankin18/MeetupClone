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
        configureTableViewProperties()
    }
    
    private func configureTableViewProperties() {
        
        tableView.register(UINib(nibName: "EventDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EventDisplayCell")
        tableView.dataSource = eventsDisplayTableViewControllerDataSource
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
    }
    
    private func retrieveGroupEvents(urlName: String) {
        
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = Bundle.main.loadNibNamed("GroupDisplayTableViewCell", owner: self, options: nil)?.first as? GroupDisplayTableViewCell
        guard let headerInformationModel = headerInformationModel else {
            return nil
        }
        headerView?.viewModel = GroupDisplayTableViewCell.ViewModel(groupName: headerInformationModel.name, groupImage: headerInformationModel.imageURL, members: nil, nextEventName: nil)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailedController = EventDetailedTableViewController(style: .grouped)
        let event = eventsDisplayTableViewControllerDataSource.items[indexPath.row]
        detailedController.headerModel = MapDisplayHeaderModel(lattitude: event.venue?.lattitude, longitude: event.venue?.longitude, eventName: event.eventName, eventLocation: event.venue?.city)
        detailedController.eventInformation = (urlName: urlName, eventId: event.eventId) as? (urlName: String, eventId: String)
        navigationController?.pushViewController(detailedController, animated: true)
    }
}
