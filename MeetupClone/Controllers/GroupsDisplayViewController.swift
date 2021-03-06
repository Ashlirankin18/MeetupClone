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
        searchController.searchBar.tintColor = .white
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.backgroundColor = .red
        searchController.isAccessibilityElement = true
        searchController.searchBar.isAccessibilityElement = true
        searchController.searchBar.accessibilityLabel = NSLocalizedString(  "Search Bar", comment: "Indicates to the user that this object is a search bar")
        searchController.accessibilityLabel = NSLocalizedString( "Search Controller", comment: "Indicates to the user that this object is a search controller")
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private let groupInfoDataSource = GroupInfoDataSource()
    
    private let meetupDataHandler = MeetupDataHandler(networkHelper: NetworkHelper(), preferences: Preferences(userDefaults: UserDefaults.standard))
    
    private var currentDataTask: Cancelable?
    
    private var emptyStateView: EmptyStateView?
    
    private let networkConnectivityHelper = NetworkConnectivityHelper()
    
    private var loadingState: LoadingState? {
        didSet {
            guard let loadingState = loadingState else {
                print("No loading state found")
                return
            }
            updatesViewBasedOnLoadingState(loadingState: loadingState)
        }
    }
    
    private var preferences = Preferences(userDefaults: UserDefaults.standard)
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet private weak var zipCodeBarButtonItem: UIBarButtonItem!
    
    @IBOutlet private weak var groupDisplayTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewProperties()
        configureNavigationItemProperties()
        checkForLastZipCodeEntered()
        networkConnectivityHelper.delegate = self
        addKeyboardNotificationObservers()
        loadEmptyState()
        hideActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showActivityIndicator()
    }
    
    private func addKeyboardNotificationObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(willHideKeyboard(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(willShowKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private func configureNavigationItemProperties() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    private func hideActivityIndicator() {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
    
    private func showActivityIndicator() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    private func loadEmptyState() {
        guard let emptyStateView = Bundle.main.loadNibNamed("EmptyStateView", owner: self, options: nil)?.first as? EmptyStateView else {
            return
        }
        self.emptyStateView = emptyStateView
        emptyStateView.isHidden = true
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyStateView)
        constrainEmptyStateView(emptyStateView: emptyStateView)
    }
    
    private func configureTableViewProperties() {
        groupDisplayTableView.dataSource = groupInfoDataSource
        groupDisplayTableView.delegate = self
        groupDisplayTableView.rowHeight = UITableView.automaticDimension
        groupDisplayTableView.register(UINib(nibName: "GroupDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "GroupDisplayCell")
    }
    
    private func updatesViewBasedOnLoadingState(loadingState: LoadingState) {
        switch loadingState {
        case .isLoading:
            showActivityIndicator()
            emptyStateView?.isHidden = true
            groupDisplayTableView.isHidden = true
        case .isFinishedLoading:
            if groupInfoDataSource.groups.isEmpty {
                emptyStateView?.isHidden = false
                groupDisplayTableView.isHidden = true
            } else {
                groupDisplayTableView.isHidden = false
                emptyStateView?.isHidden = true
            }
            hideActivityIndicator()
        }
    }
    
    private func checkForLastZipCodeEntered() {
        let zipCode = preferences.zipCode
        let searchText = preferences.serarchText
        zipCodeBarButtonItem.title = zipCode
        searchController.searchBar.text = searchText
    }
    
    @discardableResult private func retrieveGroups(searchText: String?, zipCode: String?) -> Cancelable? {
        let dataTask = meetupDataHandler.retrieveMeetupGroups(searchText: searchText ?? "", zipCode: zipCode) { [weak self] (results) in
            switch results {
            case .failure(let error):
                print(error)
            case .success(let groups):
                guard let self = self else {
                    return
                }
                self.groupInfoDataSource.groups = groups
                self.groupDisplayTableView.reloadData()
                if self.groupInfoDataSource.groups.isEmpty {
                    self.emptyStateView?.viewModel = EmptyStateView.ViewModel(emptyStateImage: .noGroupsFound, emptyStatePrompt: NSLocalizedString("No groups were found", comment: "Indicates to the user that no groups were found."))
                }
                self.loadingState = .isFinishedLoading
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
            textfield.placeholder = NSLocalizedString("Enter zip code", comment: "Prompts the user to enter their zip code.")
        }
        
        let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: "Submits Answer"), style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }
            
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
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        alertController.isAccessibilityElement = true
        present(alertController, animated: true, completion: nil)
    }
    
    private func isEnteredZipCodeValid(zipCode: String) -> Bool {
        if Int(zipCode) != nil && zipCode.count == 5 {
            zipCodeBarButtonItem.title = zipCode
            return true
        }
        return false
    }
    
    @objc func willHideKeyboard(notification: Notification) {
        groupDisplayTableView.scrollIndicatorInsets = .zero
        groupDisplayTableView.contentInset = .zero
    }
    
    @objc func willShowKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        groupDisplayTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        groupDisplayTableView.scrollIndicatorInsets = groupDisplayTableView.contentInset
    }
    
    @IBAction private func zipCodeBarButtonPressed(_ sender: UIBarButtonItem) {
        presentAlertController(message: NSLocalizedString("Enter your 5 digit zip code.", comment: "Prompts the user to enter thier desired zip code."))
    }
}
extension GroupsDisplayViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text?.lowercased() {
            if isSearchControllerInputValid() {
                loadingState = .isLoading
                if currentDataTask == nil {
                    let zipCode = preferences.zipCode
                    currentDataTask = retrieveGroups(searchText: text, zipCode: zipCode)
                    preferences.serarchText = text
                } else {
                    currentDataTask?.cancelTask()
                    let zipCode = preferences.zipCode
                    let timer = Timer(timeInterval: 1.0, repeats: false) { [weak self] _ in
                        
                        guard let self = self else {
                            return
                        }
                        self.preferences.serarchText = text
                        self.currentDataTask = self.retrieveGroups(searchText: text, zipCode: zipCode)
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
            assertionFailure("Could not instantiate view controller")
            return
        }
        let chosenGroup = groupInfoDataSource.groups[indexPath.row]
        let highResPhoto = chosenGroup.groupPhoto?.photoLink
        viewController.headerInformationModel = HeaderInformationModel(imageURL: highResPhoto, name: chosenGroup.groupName)
        
        viewController.urlName = chosenGroup.urlName
        searchController.searchBar.resignFirstResponder()
        show(viewController, sender: nil)
    }
}

extension GroupsDisplayViewController: NetworkConnectivityHelperDelegate {
    
    func networkIsAvailable() {
        if !preferences.isFirstLaunch {
            if isSearchControllerInputValid() {
                if let searchText = searchController.searchBar.text {
                    let zipCode = zipCodeBarButtonItem.title ?? ""
                    retrieveGroups(searchText: searchText, zipCode: zipCode)
                }
            } else {
                emptyStateView?.viewModel = EmptyStateView.ViewModel(emptyStateImage: .noGroupsFound, emptyStatePrompt: NSLocalizedString("Search for groups that interest you!", comment: "Prompts the user to search for their interests."))
                emptyStateView?.isHidden = false
            }
        } else {
            
            emptyStateView?.viewModel = EmptyStateView.ViewModel(emptyStateImage: .noGroupsFound, emptyStatePrompt: NSLocalizedString("Welcome! Search for the groups you like.", comment: "Indicates to the user no groups were found"))
            preferences.isFirstLaunch = !preferences.isFirstLaunch
            emptyStateView?.isHidden = false
        }
    }
    func networkIsUnavailable() {
        emptyStateView?.viewModel = EmptyStateView.ViewModel(emptyStateImage: .noInternetConnection, emptyStatePrompt: "No Internet Connection Detected")
        emptyStateView?.isHidden = false
  }
}
extension GroupsDisplayViewController {
    
    private func constrainEmptyStateView(emptyStateView: EmptyStateView) {
        NSLayoutConstraint.activate([
            emptyStateView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
}
