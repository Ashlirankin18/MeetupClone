//
//  ProfileViewController.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// Displays the users profile information.
final class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var profileControllerTableView: UITableView!
    
    private let meetupCloneDataSource = UserProfileDataSource()
    
    private let meetupDatatHandler = MeetupDataHandler(networkHelper: NetworkHelper())
    
    private let emptyStateView = EmptyStateView()
    
    private let networkConnectivityHelper = NetworkConnectivityHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if networkConnectivityHelper.isReachable {
            setUpProfileTableView()
            retrieveUserInformation()
        } else {
            
            setUpEmptyStateView(image: UIImage.noInternetConnection, prompt: "No Internet Connection detected")
        }
    }
    
    private func setUpEmptyStateView(image: UIImage?, prompt: String) {
        view.addSubview(emptyStateView)
        constrainViewToScreen(view: emptyStateView)
        emptyStateView.viewModel = EmptyStateView.ViewModel(emptyStateImage: image, emptyStatePrompt: prompt)
    }
    private func setUpProfileTableView() {
        profileControllerTableView.delegate = self
        profileControllerTableView.dataSource = meetupCloneDataSource
        profileControllerTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func retrieveUserInformation() {
        meetupDatatHandler.retrieveUserData { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let userInfo):
                guard let self = self else {
                    return
                }
                self.meetupCloneDataSource.meetupUserModel = userInfo
                self.profileControllerTableView.reloadData()
            }
        }
    }
}
extension ProfileViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("UserImageView", owner: self, options: nil)?.first as? UserImageView else {
            return UIView() }
        guard let meetupUserModel = meetupCloneDataSource.meetupUserModel else {
            return UIView()
        }
        headerView.viewModel = UserImageView.ViewModel(userImageLink: meetupUserModel.photo?.highresLink)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
}
