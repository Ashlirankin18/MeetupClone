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
    
    /// Represents the information needed to see up a EventDetailedTableViewController view
    struct ViewModel: Codable {
        
        /// The lattitude of the event
        let lattitude: Double?
        
        /// The longitude of the event
        let longitude: Double?
        
        /// The name of the event
        let eventName: String
        
        /// The name of the city where the event is being held
        let eventCity: String?
        
        /// The group's URL Name
        let urlName: String
        
        /// The event's id
        let eventId: String
        
        /// The event's description
        let description: String?
        
        /// The number of the person who have rsvp'd
        let rsvpCount: Int
        
        /// Indicates wether the event has been favorited or not.
        var isFavorited: Bool
    }
    
    private let eventDetailedControllerDataSource = EventDetailedControllerDataSource()
    
    private let meetupDataHandler = MeetupDataHandler(networkHelper: NetworkHelper())
    
    /// EventDetailedTableViewController's view model.
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = self.viewModel else {
                assertionFailure("No viewModel found")
                return
            }
            retrieveRSVPData(eventId: viewModel.eventId, eventURLName: viewModel.urlName)
        }
    }
    private var rightBarButtonItem: UIBarButtonItem?
    
    private var persistenceHelper = PersistenceHelper.self
    
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
        tableView.dataSource = eventDetailedControllerDataSource
        tableView.rowHeight = 80
        tableView.sectionHeaderHeight = UITableView.automaticDimension
    }
    
    private func configureRightBarButtonItem() {
        guard let viewModel = viewModel else {
            return
        }
        rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-heart-26"), style: .done, target: self, action: #selector(favoriteButtonPressed))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        if persistenceHelper.isEventFavorited(eventId: viewModel.eventId) {
            rightBarButtonItem?.image = UIImage(named: "icons8-heart-25")
        }
    }
    
    private func retrieveRSVPData(eventId: String, eventURLName: String) {
        meetupDataHandler.retrieveEventRSVP(eventId: eventId, eventURLName: eventURLName) { (result) in
            switch result {
            case .failure(let error):
                //TODO:- Add an empty state for a 403 error. The error should let the user know they are not a member of the group.
                print(error)
            case .success(let rsvps):
                self.eventDetailedControllerDataSource.rsvps = rsvps
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func favoriteButtonPressed() {
        guard let viewModel = viewModel else {
            return
        }
        toggleButtonImage(eventId: viewModel.eventId)
    }
    
    private func toggleButtonImage(eventId: String) {
        guard let viewModel = viewModel else {
            return
        }
        if !persistenceHelper.isEventFavorited(eventId: eventId) {
            rightBarButtonItem?.image = UIImage(named: "icons8-heart-25")
            persistenceHelper.addFavoriteEventToDocumentsDirectory(favoriteEvent: viewModel)
        } else {
            rightBarButtonItem?.image = UIImage(named: "icons8-heart-26")
            persistenceHelper.deleteItemFromDocumentsDirectory(favoriteEvent: viewModel)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("EventHeaderView", owner: self, options: nil)?.first as? EventHeaderView,
            let headerModel = viewModel else {
                return UIView()
        }
        if let lattitude = headerModel.lattitude,
            let longitude = headerModel.longitude {
            headerView.viewModel = EventHeaderView.ViewModel(eventCoordinates: CLLocationCoordinate2D(latitude: lattitude, longitude: longitude), eventName: headerModel.eventName, eventLocation: headerModel.eventCity)
        } else {
            headerView.viewModel = EventHeaderView.ViewModel(eventCoordinates: nil, eventName: headerModel.eventName, eventLocation: headerModel.eventCity)
        }
        return headerView
    }
}
