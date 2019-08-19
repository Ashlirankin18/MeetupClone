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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = persistenceHelper.shared.retrieveFavoriteEventsFromDocumentsDirectory()[indexPath.row]
        let detailedController = EventDetailedTableViewController(style: .grouped)
        detailedController.meetupEventModel = event
        navigationController?.pushViewController(detailedController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("GroupDisplayTableViewCell", owner: self, options: nil)?.first as? GroupDisplayTableViewCell else {
            return UIView()
        }
        guard let url = URL(string: "https://thememylogin.com/app/uploads/edd/2019/03/favorites.png") else {
            return UIView()
        }
        
        headerView.viewModel = GroupDisplayTableViewCell.ViewModel(groupName: nil, groupImage: url, members: nil, nextEventName: nil)
        return headerView
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
} 
