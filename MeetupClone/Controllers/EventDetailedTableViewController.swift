//
//  EventDetailedTableViewController.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/8/19.
//  Copyright © 2019 Lickability. All rights reserved.
//
import UIKit
import CoreLocation
import MapKit

/// `UITableViewController` subclass that will display MeetUpEvent location details and the persons who have rsvp'd to an event.
final class EventDetailedTableViewController: UITableViewController {
    
    private let eventDetailedControllerDataSource = EventDetailedControllerDataSource()
    
    private let meetupDataHandler = MeetupDataHandler(networkHelper: NetworkHelper())
    
    /// The URL Name of the meetup group
    var urlName: String?
    
    /// Model representing an event object.
    var meetupEventModel: MeetupEventModel? {
        didSet {
            guard let meetupEventModel = meetupEventModel else {
                    assertionFailure("No eventModel found")
                    return
            }
            let urlName = meetupEventModel.group.urlName
            retrieveRSVPData(eventId: meetupEventModel.eventId, eventURLName: urlName)
        }
    }
    
    private lazy var rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-heart-26"), style: .done, target: self, action: #selector(favoriteButtonPressed))
    
    private var persistenceHelper = PersistenceHelper.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewProperties()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureRightBarButtonItem()
    }
    
    private func configureTableViewProperties() {
        tableView.register(UINib(nibName: "MeetupMemberDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MemberCell")
        tableView.register(UINib(nibName: "EmptyStateTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EmptyStateCell")
        tableView.dataSource = eventDetailedControllerDataSource
        tableView.rowHeight = 80
        tableView.sectionHeaderHeight = UITableView.automaticDimension
    }
    
    private func configureRightBarButtonItem() {
        guard let meetupEventModel = meetupEventModel else {
            return
        }
        navigationItem.rightBarButtonItem = rightBarButtonItem
        if persistenceHelper.isEventFavorited(eventId: meetupEventModel.eventId) {
            rightBarButtonItem.image = UIImage(named: "icons8-heart-25")
        }
    }
    
    private func retrieveRSVPData(eventId: String?, eventURLName: String) {
        guard let eventId = eventId else {
            assertionFailure("Event Id could not be found")
            return
        }
        meetupDataHandler.retrieveEventRSVP(eventId: eventId, eventURLName: eventURLName) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let rsvps):
                self.eventDetailedControllerDataSource.rsvps = rsvps
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func favoriteButtonPressed() {
        guard let meetupEventModel = meetupEventModel else {
            return
        }
        toggleButtonImage(eventId: meetupEventModel.eventId)
    }
    
    private func toggleButtonImage(eventId: String) {
        guard let meetupEventModel = meetupEventModel else {
            return
        }
        if !persistenceHelper.isEventFavorited(eventId: eventId) {
            rightBarButtonItem.image = UIImage(named: "icons8-heart-25")
            persistenceHelper.addFavoriteEventToDocumentsDirectory(favoriteEvent: meetupEventModel)
        } else {
            rightBarButtonItem.image = UIImage(named: "icons8-heart-26")
            persistenceHelper.deleteItemFromDocumentsDirectory(favoriteEvent: meetupEventModel)
        }
    }
    
    // Mark: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("EventHeaderView", owner: self, options: nil)?.first as? EventHeaderView,
            let meetupEventModel = meetupEventModel else {
                return UIView()
        }
        if let lattitude = meetupEventModel.venue?.lattitude,
            let longitude = meetupEventModel.venue?.longitude {
            headerView.viewModel = EventHeaderView.ViewModel(eventCoordinates: CLLocationCoordinate2D(latitude: lattitude, longitude: longitude), eventName: meetupEventModel.eventName, eventLocation: meetupEventModel.venue?.city)
        } else {
            headerView.viewModel = EventHeaderView.ViewModel(eventCoordinates: nil, eventName: meetupEventModel.eventName, eventLocation: meetupEventModel.venue?.city)
        }
        return headerView
    }
}
