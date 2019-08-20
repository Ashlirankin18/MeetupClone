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
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    private func configureTableViewProperties() {
        tableView.register(UINib(nibName: "EventDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EventDisplayCell")
        tableView.dataSource = favoritesTableViewControllerDataSource
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = persistenceHelper.shared.retrieveFavoriteEventsFromDocumentsDirectory()[indexPath.row]
        let detailedController = EventDetailedTableViewController(style: .grouped)
        detailedController.meetupEventModel = event
        self.show(detailedController, sender: self)
    }
} 
