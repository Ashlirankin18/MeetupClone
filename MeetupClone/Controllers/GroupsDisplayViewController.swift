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
    
    @IBOutlet private weak var zipCodeBarButton: UIBarButtonItem!
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
        checkForLastZipCodeEntered()
    }
    
    private func checkForLastZipCodeEntered() {
        let userDefaults = UserDefaults.standard
        if let zipCode = userDefaults.object(forKey: UserDefaultConstants.zipcode.rawValue) as? String,
            let searchText = userDefaults.object(forKey: UserDefaultConstants.searchText.rawValue) as? String {
            retrieveGroups(searchText: searchText, zipCode: zipCode)
            searchController.searchBar.text = searchText
            zipCodeBarButton.title = zipCode
        }
    }
    
    private func configureTableViewProperties() {
        groupDisplayTableView.dataSource = groupInfoDataSource
        groupDisplayTableView.delegate = self
        groupDisplayTableView.rowHeight = UITableView.automaticDimension
        groupDisplayTableView.register(UINib(nibName: "GroupDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "GroupDisplayCell")
    }
    
    @discardableResult private func retrieveGroups(searchText: String?, zipCode: String?) -> Cancelable? {
        let dataTask = meetupDataHandler.retrieveMeetupGroups(searchText: searchText ?? "", zipCode: zipCode) { (results) in
            switch results {
            case .failure(let error):
                print(error)
            case .success(let groups):
                self.groupInfoDataSource.groups = groups
                self.groupDisplayTableView.reloadData()
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
    
    private func presentAlertController(message: String) {
        let alertController = UIAlertController(title: NSLocalizedString("Add Zip Code", comment: "The zip code the user desires"), message: message, preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        
        let submitAction = UIAlertAction(title: NSLocalizedString("Submit", comment: "Submit Answer"), style: .default) { _ in
            guard let zipCode = alertController.textFields?.first?.text else {
                return
            }
            if zipCode.count > 5 {
                self.presentAlertController(message: NSLocalizedString("Zip Code should be 5 digits", comment: "Promptas user to enter zipcode of five digits"))
            } else {
                if self.parseZipCode(zipCode: zipCode) {
                    UserDefaults.standard.set(zipCode, forKey: UserDefaultConstants.zipcode.rawValue)
                } else {
                    self.presentAlertController(message: NSLocalizedString("Enter zipcode in format ex: 11001", comment: "Prompts the user to enter zipcode in required format."))
                }
            }
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel action"), style: .cancel, handler: nil)
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func parseZipCode(zipCode: String) -> Bool {
        if Int(zipCode) != nil {
            return true
        }
        return false
    }
    
    @IBAction private func zipCodeBarButtonPressed(_ sender: UIBarButtonItem) {
        presentAlertController(message: NSLocalizedString("Enter you 5 digit zipcode.", comment: "Prompts the user to enter thier desired zipcode."))
    }
}
extension GroupsDisplayViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let userDefaults = UserDefaults.standard
        if let text = searchController.searchBar.text?.lowercased() {
            userDefaults.set(text, forKey: UserDefaultConstants.searchText.rawValue)
            if isSearchControllerInputValid() {
                if currentDataTask == nil {
                    let zipCode = userDefaults.object(forKey: UserDefaultConstants.zipcode.rawValue) as? String ?? ""
                    currentDataTask = retrieveGroups(searchText: text, zipCode: zipCode)
                } else {
                    currentDataTask?.cancelTask()
                    let timer = Timer(timeInterval: 1.0, repeats: false) { _ in
                        self.currentDataTask = self.retrieveGroups(searchText: text, zipCode: nil)
                    }
                    
                    timer.fire()
                }
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
