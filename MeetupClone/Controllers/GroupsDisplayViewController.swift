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
    
    @IBOutlet private weak var zipCodeBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var groupDisplayTableView: UITableView!
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.tintColor = .white
        searchController.searchBar.searchBarStyle = .prominent
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
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(willHideKeyboard(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(willShowKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private func checkForLastZipCodeEntered() {
        let userDefaults = UserDefaults.standard
        if let zipCode = userDefaults.object(forKey: UserDefaultConstants.zipCode.rawValue) as? String,
            let searchText = userDefaults.object(forKey: UserDefaultConstants.searchText.rawValue) as? String {
            zipCodeBarButtonItem.title = zipCode
            searchController.searchBar.text = searchText
        } else {
            searchController.searchBar.placeholder = NSLocalizedString("Search for group", comment: "Prompts the user to search for a group.")
        }
    }
    
    private func configureTableViewProperties() {
        groupDisplayTableView.dataSource = groupInfoDataSource
        groupDisplayTableView.delegate = self
        groupDisplayTableView.rowHeight = UITableView.automaticDimension
        groupDisplayTableView.register(UINib(nibName: "GroupDisplayTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "GroupDisplayCell")
        groupDisplayTableView.register(UINib(nibName: "EmptyStateTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "EmptyStateCell")
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
        return text.count >= 3
    }
    
    private func presentAlertController(message: String) {
        let alertController = UIAlertController(title: NSLocalizedString("Add Zip Code", comment: "The zip code the user desires"), message: message, preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.keyboardType = .numberPad
        }
        
        let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: "Submit Answer"), style: .default) { _ in
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
        self.present(alertController, animated: true, completion: nil)
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
        let userDefaults = UserDefaults.standard
        if let text = searchController.searchBar.text?.lowercased() {
            userDefaults.set(text, forKey: UserDefaultConstants.searchText.rawValue)
            if isSearchControllerInputValid() {
                if currentDataTask == nil {
                    let zipCode = userDefaults.object(forKey: UserDefaultConstants.zipCode.rawValue) as? String ?? ""
                    currentDataTask = retrieveGroups(searchText: text, zipCode: zipCode)
                } else {
                    currentDataTask?.cancelTask()
                    let zipCode = userDefaults.object(forKey: UserDefaultConstants.zipCode.rawValue) as? String ?? ""
                    let timer = Timer(timeInterval: 1.0, repeats: false) { _ in
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
