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
    
    var loadingState: LoadingState? {
        didSet {
            guard let loadingState = loadingState else {
                return
            }
            updatesViewBasedOnLoadingState(loadingState: loadingState)
        }
    }
    private let eventsDisplayTableViewControllerDataSource = EventsDisplayTableViewControllerDataSource()
    
    private let meetupDataHandler = MeetupDataHandler(networkHelper: NetworkHelper())
    
    private var emptyStateView: EmptyStateView? {
        didSet {
            guard let emptyStateView = emptyStateView else {
                return
            }
            view.addSubview(emptyStateView)
            constrainEmptyStateView(emptyStateView: emptyStateView)
        }
    }
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewProperties()
        navigationItem.largeTitleDisplayMode = .never
        loadNib()
        self.loadingState = .isLoading
    }
    
    private func updatesViewBasedOnLoadingState(loadingState: LoadingState) {
        switch loadingState {
        case .isLoading:
            showActivityIndicator()
            emptyStateView?.isHidden = true
        case .isFinishedLoading:
            hideActivityIndicator()
        }
    }
    
    private func showActivityIndicator() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
    
    private func showEmptyStateView() {
        emptyStateView?.viewModel = EmptyStateView.ViewModel(emptyStateImage: .noEventsFound, emptyStatePrompt: NSLocalizedString("This group has no upcoming events", comment: "Indicates to the user that they have no upcoming events"))
        self.emptyStateView?.isHidden = false
    }
    
    private func loadNib () {
        guard let emptyStateView = Bundle.main.loadNibNamed("EmptyStateView", owner: self, options: nil)?.first as? EmptyStateView else {
            assertionFailure("Could not load nib")
            return
        }
        self.emptyStateView = emptyStateView
    }
    private func configureTableViewProperties() {
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
                if events.isEmpty {
                    self.showEmptyStateView()
                } else {
                    self.tableView.isHidden = false
                    self.eventsDisplayTableViewControllerDataSource.events = events
                    self.tableView.reloadData()
                    self.emptyStateView?.isHidden = true
                }
                self.loadingState = .isFinishedLoading
            }
        }
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if eventsDisplayTableViewControllerDataSource.events.isEmpty {
            return nil
        } else {
            let headerView = Bundle.main.loadNibNamed("GroupDisplayTableViewCell", owner: self, options: nil)?.first as? GroupDisplayTableViewCell
            guard let headerInformationModel = headerInformationModel else {
                return nil
            }
            headerView?.viewModel = GroupDisplayTableViewCell.ViewModel(groupName: headerInformationModel.name, groupImage: headerInformationModel.imageURL, members: nil, nextEventName: nil, date: nil)
            
            return headerView
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { 
        let detailedController = EventDetailedTableViewController(style: .grouped)
        let event = eventsDisplayTableViewControllerDataSource.events[indexPath.row]
        detailedController.meetupEventModel = event
        show(detailedController, sender: self)
    }
}
extension EventsDisplayTableViewController {
    func constrainEmptyStateView(emptyStateView: EmptyStateView) {
        NSLayoutConstraint.activate([
            emptyStateView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}
