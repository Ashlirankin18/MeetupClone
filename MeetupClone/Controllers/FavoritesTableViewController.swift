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
    private let persistenceHelper = PersistenceHelper.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewProperties()
        title = NSLocalizedString("My Favorites", comment: "Indicates to the user the tab they are on")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    private func configureTableViewProperties() {
        tableView.register(UINib(nibName: "EventDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EventDisplayCell")
        tableView.dataSource = favoritesTableViewControllerDataSource
    }
}
