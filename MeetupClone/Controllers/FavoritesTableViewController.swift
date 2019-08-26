//
//  FavoritesTableViewController.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// Shows the groups that the user has favorited 
final class FavoritesTableViewController: UITableViewController {
    
    private let favoritesTableViewControllerDataSource = FavoritesTableViewControllerDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewProperties()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    private func configureTableViewProperties() {
        tableView.register(UINib(nibName: "EventDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EventDisplayCell")
        tableView.register(UINib(nibName: "EmptyStateTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EmptyStateCell")
        tableView.dataSource = favoritesTableViewControllerDataSource
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorites = PersistenceHelper.shared.favoriteEvents
        let detailedController = EventDetailedTableViewController(style: .grouped)
        detailedController.meetupEventModel = event
        show(detailedController, sender: self)
    }
} 
