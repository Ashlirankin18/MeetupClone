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
    
    /// Represents the model used to set up the headerView of the model
    var meetupEventModel: MeetupEventModel?
    
    /// The information needed to make the network call to retrieve rsvp data.
    var eventInformation: (urlName: String, eventId: String)? {
        
        didSet {
            guard let eventInformation = eventInformation else {
                return
            }
            retrieveRSVPData(eventId: eventInformation.eventId, eventURLName: eventInformation.urlName)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureTableViewProperties()
        configureBarButtonItem()
    }
    
    private func configureTableViewProperties() {
        
        tableView.register(UINib(nibName: "MeetupMemberDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MemberCell")
        tableView.dataSource = eventDetailedControllerDataSource
        tableView.rowHeight = 80
        tableView.sectionHeaderHeight = UITableView.automaticDimension
    }
    
    private func configureBarButtonItem() {
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-heart-26"), style: .done, target: self, action: #selector(favoriteButtonPressed))
        navigationItem.rightBarButtonItem = rightBarButtonItem
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
    }
    
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
        headerView.eventHeaderViewDelegate = self
        return headerView
    }
}

extension EventDetailedTableViewController: EventHeaderViewDelegate {
    
    func showAnnotationView(mapView: MKMapView, annotation: MKAnnotation) {
        mapView.showAnnotations([annotation], animated: true)
    }
}
