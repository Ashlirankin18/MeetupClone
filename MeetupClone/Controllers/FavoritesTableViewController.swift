//
//  FavoritesTableViewController.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// `UITableViewController` subclass which shows the groups that the user has favorited.
final class FavoritesTableViewController: UITableViewController {
    
    private let favoritesTableViewControllerDataSource = FavoritesTableViewControllerDataSource()
    
    private var emptyStateView: EmptyStateView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewProperties()
        loadEmptyView()
        setEmptyStateViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        configureAndDisplayEmptyStateView()
    }
    
    private func loadEmptyView() {
        guard let emptyStateView = Bundle.main.loadNibNamed("EmptyStateView", owner: self, options: nil)?.first as? EmptyStateView else {
            assertionFailure("Could not load nib.")
            return
        }
        self.emptyStateView = emptyStateView
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyStateView)
        constrainEmptyStateView(emptyStateView: emptyStateView)
    }
    
    private func configureAndDisplayEmptyStateView() {
        let isEmpty = PersistenceHelper.shared.favoriteEvents.isEmpty
        emptyStateView?.isHidden = !isEmpty
        tableView.isScrollEnabled = !isEmpty
    }
    
    private func setEmptyStateViewModel() {
        emptyStateView?.viewModel = EmptyStateView.ViewModel(emptyStateImage: .noFavoritesFound, emptyStatePrompt: NSLocalizedString("You have no favorite events", comment: "Indicates to the user that they have no favorite events."))
    }
    private func configureTableViewProperties() {
        tableView.register(UINib(nibName: "EventDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EventDisplayCell")
        tableView.dataSource = favoritesTableViewControllerDataSource
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorites = PersistenceHelper.shared.favoriteEvents[indexPath.row]
        let detailedController = EventDetailedTableViewController(style: .grouped)
        detailedController.meetupEventModel = favorites
        show(detailedController, sender: self)
    }
} 
extension FavoritesTableViewController {
    private func constrainEmptyStateView(emptyStateView: EmptyStateView) {
        NSLayoutConstraint.activate([
            emptyStateView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
            ])
    }
}
