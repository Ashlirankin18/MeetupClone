//
//  GroupDisplayViewController.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// Display a list of groups that the user searches for.
class GroupDisplayViewController: UIViewController {
    private let meetUpDataHandler = MeetupDataHandler(networkHelper: NetworkHelper())
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.definesPresentationContext = true
        return searchController
    }()
    
    @IBOutlet private weak var zipCodeButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationSpecifices()
        setupSearchController()
        retrieveGroups()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for Groups"
    }
    
    private func setNavigationSpecifices() {
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        definesPresentationContext = true
    }
    
    private func retrieveGroups() {
        meetUpDataHandler.retrieveMeetupGroups(zipCode: 11429) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let groups):
                print(groups)
            }
        }
    }
    
    @IBAction private func zipCodeButtonPressed(_ sender: UIBarButtonItem) {
    }
}
extension GroupDisplayViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {}
}
