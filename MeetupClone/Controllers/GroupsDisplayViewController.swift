//
//  GroupsDisplayViewController.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// A `UIViewController` subclass which displays a list of groups that the user searches for.
final class GroupsDisplayViewController: UIViewController {
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        return searchController
    }()
    
    private let groupInfoDataSource = GroupInfoDataSource()
    
    private let meetupDataHandler = MeetupDataHandler(networkHelper: NetworkHelper())
    
    private var currentDataTask: Cancelable?
    
    private var emptyStateView = EmptyStateView()
    
    private var loadingState: LoadingState? {
        didSet {
            guard let loadingState = loadingState else {
                print("No loading state found")
                return
            }
            updatesViewBasedOnLoadingState(loadingState: loadingState)
        }
    }
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var zipCodeBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var groupDisplayTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewProperties()
        configureNavigationItemProperties()
        checkForLastZipCodeEntered()
        setUpEmptyStateView()
        setUpActivityIndicator()
    }
    
    private func configureNavigationItemProperties() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func setUpEmptyStateView() {
        view.addSubview(emptyStateView)
        emptyStateView.viewModel = EmptyStateView.ViewModel(emptyStateImage: .noGroupsFound, emptyStatePrompt: NSLocalizedString("No groups were found. Try searching for your interests", comment: "Prompts the user to search for their interests."))
    }
    
    private func setUpActivityIndicator() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    private func configureTableViewProperties() {
        groupDisplayTableView.dataSource = groupInfoDataSource
        groupDisplayTableView.delegate = self
        groupDisplayTableView.rowHeight = UITableView.automaticDimension
        groupDisplayTableView.register(UINib(nibName: "GroupDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "GroupDisplayCell")
    }
    
    private func showEmptyState() {
        emptyStateView.isHidden = false
    }
    
    private func hideEmptyState() {
        emptyStateView.isHidden = true
    }
    
    private func hideActivityIndicator() {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
    
    private func showActivityIndicator() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    private func showTableView() {
        groupDisplayTableView.isHidden = false
    }
    
    private func updatesViewBasedOnLoadingState(loadingState: LoadingState) {
        switch loadingState {
        case .isLoading:
            showActivityIndicator()
        case .isFinishedLoading:
            hideActivityIndicator()
            if groupInfoDataSource.groups.isEmpty {
                showEmptyState()
            } else {
                showTableView()
                hideEmptyState()
            }
        }
    }
    
    private func checkForLastZipCodeEntered() {
        let userDefaults = UserDefaults.standard
        if let zipCode = userDefaults.object(forKey: UserDefaultConstants.zipCode.rawValue) as? String,
            let searchText = userDefaults.object(forKey: UserDefaultConstants.searchText.rawValue) as? String {
            zipCodeBarButtonItem.title = zipCode
            searchController.searchBar.text = searchText
            loadingState = .isFinishedLoading
        } else {
            searchController.searchBar.placeholder = NSLocalizedString("Search for group", comment: "Prompts the user to search for a group.")
        }
    }
    
    @discardableResult private func retrieveGroups(searchText: String?, zipCode: String?) -> Cancelable? {
        let dataTask = meetupDataHandler.retrieveMeetupGroups(searchText: searchText ?? "", zipCode: zipCode) { [weak self] (results) in
            switch results {
            case .failure(let error):
                print(error)
            case .success(let groups):
                self?.groupInfoDataSource.groups = groups
                self?.groupDisplayTableView.reloadData()
                self?.loadingState = .isFinishedLoading
            }
        }
        return dataTask
    }
    
    private func isSearchControllerInputValid() -> Bool {
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.count >= 3
    }
    
    private func presentAlertController(message: String) {
        let alertController = UIAlertController(title: NSLocalizedString("Add Zip Code", comment: "The zip code the user desires"), message: message, preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.keyboardType = .numberPad
        }
        
        let submitAction = UIAlertAction(title: NSLocalizedString("Submit", comment: "Submit Answer"), style: .default) { [unowned self] _ in
            guard let zipCode = alertController.textFields?.first?.text else {
                return
            }
            
            if self.isEnteredZipCodeValid(zipCode: zipCode) {
                self.zipCodeBarButtonItem.title = zipCode
                UserDefaults.standard.set(zipCode, forKey: UserDefaultConstants.zipCode.rawValue)
            } else {
                self.presentAlertController(message: NSLocalizedString("Enter zip code in format ex: 11001", comment: "Prompts the user to enter zip code in required format."))
            }
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel action"), style: .cancel, handler: nil)
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func isEnteredZipCodeValid(zipCode: String) -> Bool {
        if Int(zipCode) != nil && zipCode.count == 5 {
            return true
        }
        return false
    }
    
    @IBAction private func zipCodeBarButtonPressed(_ sender: UIBarButtonItem) {
        presentAlertController(message: NSLocalizedString("Enter your 5 digit zip code.", comment: "Prompts the user to enter thier desired zip code."))
    }
}
extension GroupsDisplayViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let userDefaults = UserDefaults.standard
        if let text = searchController.searchBar.text?.lowercased() {
            userDefaults.set(text, forKey: UserDefaultConstants.searchText.rawValue)
            if isSearchControllerInputValid() {
                loadingState = .isLoading
                if currentDataTask == nil {
                    let zipCode = userDefaults.object(forKey: UserDefaultConstants.zipCode.rawValue) as? String ?? ""
                    currentDataTask = retrieveGroups(searchText: text, zipCode: zipCode)
                } else {
                    currentDataTask?.cancelTask()
                    let zipCode = userDefaults.object(forKey: UserDefaultConstants.zipCode.rawValue) as? String ?? ""
                    let timer = Timer(timeInterval: 1.0, repeats: false) { [weak self] _ in
                        self?.currentDataTask = self?.retrieveGroups(searchText: text, zipCode: zipCode)
                    }
                    
                    timer.fire()
                }
            }
        }
    }
}
extension GroupsDisplayViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = UIStoryboard(name: "Events", bundle: nil).instantiateViewController(withIdentifier: "EventsDisplayController") as? EventsDisplayTableViewController else {
            assertionFailure("could not instantiate view controller")
            return
        }
        let chosenGroup = groupInfoDataSource.groups[indexPath.row]
        let highResPhoto = chosenGroup.groupPhoto?.photoLink
        viewController.headerInformationModel = HeaderInformationModel(imageURL: highResPhoto, name: chosenGroup.groupName)
        
        viewController.urlName = chosenGroup.urlName
        navigationController?.pushViewController(viewController, animated: true)
    }
}
