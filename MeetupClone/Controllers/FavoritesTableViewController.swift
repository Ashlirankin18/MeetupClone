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
    
    private let favoritesTableViewControllerDataSource = FavoritesTableViewControllerDatasource() 
    
    private var persistenceHelper = PersistenceHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewProperties()
    }
    
    private func configureTableViewProperties() {
        tableView.register(UINib(nibName: "EventDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EventDisplayCell")
        tableView.dataSource = favoritesTableViewControllerDataSource
        favoritesTableViewControllerDataSource.favoriteEvents = persistenceHelper.retrieveFavoriteEventsFromDocumentsDirectory()
        tableView.reloadData()
    }
}
