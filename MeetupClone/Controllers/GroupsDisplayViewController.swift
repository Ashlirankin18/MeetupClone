//
//  GroupsDisplayViewController.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// Display a list of groups that the user searches for.
final class GroupsDisplayViewController: UIViewController {
    
    @IBOutlet private weak var groupDisplayTableView: UITableView!
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        return searchController
    }()
    
    private let groupInfoDataSource = GroupInfoDataSource()
    
    private let meetupDataHandler = MeetupDataHandler(networkHelper: NetworkHelper())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewProperties()
        configureSearchController()
    }
    
    private func configureTableViewProperties() {
        groupDisplayTableView.dataSource = groupInfoDataSource
        groupDisplayTableView.rowHeight = UITableView.automaticDimension
        groupDisplayTableView.register(UINib(nibName: "GroupDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "GroupDisplayCell")
    }
    
    private func configureSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
    
    private func retrieveGroups(searchText: String?, zipCode: Int?) {
        meetupDataHandler.retrieveMeetupGroups(searchText: searchText ?? "", zipCode: nil) { (results) in
            switch results {
            case .failure(let error):
                print(error)
            case .success(let groups):
                if groups.isEmpty {
                    // TODO:- The Empty State Controller
                } else {
                    self.groupInfoDataSource.groups = groups
                    self.groupDisplayTableView.reloadData()
                }
            }
        }
    }
    
    private func checksForInputCount() -> Bool {
        if let text = searchController.searchBar.text {
            if text.count > 3 {
                return true
            } else {
                return false
            }
        }
        return false
    }
}
extension GroupsDisplayViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if checksForInputCount() && meetupDataHandler.dataTask == nil {                self.retrieveGroups(searchText: searchController.searchBar.text?.lowercased(), zipCode: nil)
        }
        return
    }
}
