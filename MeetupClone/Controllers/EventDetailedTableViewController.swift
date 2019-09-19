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
    
    private let meetupDataHandler = MeetupDataHandler(networkHelper: NetworkHelper(), preferences: Preferences(userDefaults: UserDefaults.standard))
    
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
    private weak var emptyStateView: EmptyStateView?
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    private lazy var rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icons8-heart-26"), style: .done, target: self, action: #selector(favoriteButtonPressed))
    
    private var persistenceHelper = PersistenceHelper.shared
    
    private var loadingState: LoadingState? {
        didSet {
            guard let loadingState = self.loadingState else {
                return
            }
            updateViewBasedOnLoadingState(loadingState: loadingState)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewProperties()
        loadEmptyStateView()
        setupEmptyStateView()
        loadingState = .isLoading
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureRightBarButtonItem()
    }
    
    private func updateViewBasedOnLoadingState(loadingState: LoadingState) {
        switch loadingState {
        case .isLoading:
            showActivityIndicator()
            emptyStateView?.isHidden = true
        case .isFinishedLoading:
            hideActivityIndicator()
        }
    }
    
    private func showActivityIndicator() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
    }
    
    private func hideActivityIndicator() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
    private func loadEmptyStateView() {
        guard let emptyStateView = Bundle.main.loadNibNamed("EmptyStateView", owner: self, options: nil)?.first as? EmptyStateView else {
            return
        }
        self.emptyStateView = emptyStateView
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyStateView)
        constrainEmptyStateView(emptyStateView: emptyStateView)
        emptyStateView.isHidden = true
    }
    private func setupEmptyStateView() {
        guard let emptyStateView = emptyStateView else {
            return
        }
        emptyStateView.viewModel = EmptyStateView.ViewModel(emptyStateImage: .notAGroupMember, emptyStatePrompt: "You are not a member of this group")
        emptyStateView.isHidden = false
    }
    
    private func configureTableViewProperties() {
        tableView.register(UINib(nibName: "MeetupMemberDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MemberCell")
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
        meetupDataHandler.retrieveEventRSVP(eventId: eventId, eventURLName: eventURLName) { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.loadingState = .isFinishedLoading
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
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let meetupEventModel = meetupEventModel else {
            return  nil
        }
        if let lattitude = meetupEventModel.venue?.lattitude,
            let longitude = meetupEventModel.venue?.longitude {
            guard let headerView = Bundle.main.loadNibNamed("EventHeaderView", owner: self, options: nil)?.first as? EventHeaderView else {
                return UIView()
            }
            headerView.viewModel = EventHeaderView.ViewModel(eventCoordinates: CLLocationCoordinate2D(latitude: lattitude, longitude: longitude), eventName: meetupEventModel.eventName, eventLocation: meetupEventModel.venue?.city)
            return headerView
        } else {
            emptyStateView?.isHidden = false
            return UIView()
        }
    }
}
extension EventDetailedTableViewController {
    func constrainEmptyStateView(emptyStateView: EmptyStateView) {
        NSLayoutConstraint.activate([
            emptyStateView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            emptyStateView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
            ])
    }
}
