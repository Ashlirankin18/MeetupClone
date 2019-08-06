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
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
       
        return searchController
    }()
    
    private let groupInfoDataSource = GroupInfoDataSource()
    
    private let meetupDataHandler = MeetupDataHandler(networkHelper: NetworkHelper())
    
    private var currentDataTask: Cancelable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewProperties()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func configureTableViewProperties() {
        groupDisplayTableView.dataSource = groupInfoDataSource
        groupDisplayTableView.delegate = self
        groupDisplayTableView.rowHeight = UITableView.automaticDimension
        groupDisplayTableView.register(UINib(nibName: "GroupDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "GroupDisplayCell")
    }
    
    private func retrieveGroups(searchText: String?, zipCode: Int?) -> Cancelable? {
        let dataTask = meetupDataHandler.retrieveMeetupGroups(searchText: searchText ?? "", zipCode: nil) { (results) in
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
        return dataTask
    }
    
    private func isSearchControllerInputValid() -> Bool {
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.count > 3
    }
}
extension GroupsDisplayViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if isSearchControllerInputValid() {
            if currentDataTask == nil {
                currentDataTask = retrieveGroups(searchText: searchController.searchBar.text?.lowercased(), zipCode: nil)
            } else {
                currentDataTask?.cancelTask()
                let timer = Timer(timeInterval: 1.0, repeats: false) { _ in
                    self.currentDataTask = self.retrieveGroups(searchText: searchController.searchBar.text?.lowercased(), zipCode: nil)
                }
                
                timer.fire()
            }
        }
    }
}
extension GroupsDisplayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}
