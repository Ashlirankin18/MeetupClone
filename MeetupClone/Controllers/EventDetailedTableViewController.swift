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
    let eventDetailedControllerDataSource = EventDetailedControllerDataSource()
    
    var headerModel: MapDisplayHeaderModel?
   
    var eventCredentials: (urlName: String, eventId: String)? {
        didSet {
            guard let eventCredentials = eventCredentials else {
                return
            }
            retrieveRSVPData(eventId: eventCredentials.eventId, eventURLName: eventCredentials.urlName)
        }
    }
    
    private let meetupDataHandler = MeetupDataHandler(networkHelper: NetworkHelper())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MeetupMemberDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MemberCell")
        tableView.dataSource = eventDetailedControllerDataSource
        tableView.rowHeight = 80
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        configureBarButtonItem()
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
                self.eventDetailedControllerDataSource.items = rsvps
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func favoriteButtonPressed() {
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("EventHeaderView", owner: self, options: nil)?.first as? EventHeaderView,
        let headerModel = headerModel else {
            return UIView()
        }
        if let lattitude = headerModel.lattitude,
            let longitude = headerModel.longitude {
           headerView.viewModel = EventHeaderView.ViewModel(eventCoordinates: CLLocationCoordinate2D(latitude: lattitude, longitude: longitude), eventName: headerModel.eventName, eventLocation: headerModel.eventLocation)
              headerView.eventHeaderViewDelegate = self
        } else {
            headerView.viewModel = EventHeaderView.ViewModel(eventCoordinates: nil, eventName: headerModel.eventName, eventLocation: headerModel.eventLocation)
        }
        return headerView
    }
}
extension EventDetailedTableViewController: EventHeaderViewDelegate {
    func showAnnotationView(mapView: MKMapView, annotation: MKAnnotation) {
        mapView.showAnnotations([annotation], animated: true)
    }
}
