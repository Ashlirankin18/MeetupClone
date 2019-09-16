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
    
    private let meetupCloneDataSource = UserProfileDataSource()
    
    private let meetupDatatHandler = MeetupDataHandler(networkHelper: NetworkHelper())
    
    private var emptyStateView: EmptyStateView?
    
    private let networkConnectivityHelper = NetworkConnectivityHelper()
    
    private var loadingState: LoadingState?
    
    @IBOutlet private weak var profileControllerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveUserInformation()
        loadEmptyStateView()
        networkConnectivityHelper.delegate = self
        setUpProfileTableView()
        setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func loadEmptyStateView() {
        guard let emptyStateView = Bundle.main.loadNibNamed("EmptyStateView", owner: self, options: nil)?.first as? EmptyStateView else {
            return
        }
        self.emptyStateView = emptyStateView
        view.addSubview(emptyStateView)
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        constrainEmptyStateView(emptyStateView: emptyStateView)
        emptyStateView.isHidden = true
    }
    
    private func setUpEmptyStateView(image: UIImage?, prompt: String) {
        guard let emptyStateView = emptyStateView else {
            return
        }
        emptyStateView.viewModel = EmptyStateView.ViewModel(emptyStateImage: image, emptyStatePrompt: prompt)
        emptyStateView.isHidden = false
    }
    private func setUpProfileTableView() {
        profileControllerTableView.delegate = self
        profileControllerTableView.dataSource = meetupCloneDataSource
        profileControllerTableView.rowHeight = UITableView.automaticDimension
        profileControllerTableView.register(UINib(nibName: "UserNameTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "UserNameCell")
        profileControllerTableView.register(UINib(nibName: "UserBioTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "UserBioCell")
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
                self.loadingState = .isFinishedLoading
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
extension ProfileViewController: NetworkConnectivityHelperDelegate {
    func networkIsAvailable() {
        emptyStateView?.isHidden = true
        profileControllerTableView.isHidden = false
    }
    
    func networkIsUnavailable() {
        setUpEmptyStateView(image: UIImage.noInternetConnection, prompt: "No Internet Connection detected")
        profileControllerTableView.isHidden = true
    }
}
extension ProfileViewController {
    private func constrainEmptyStateView(emptyStateView: EmptyStateView) {
        NSLayoutConstraint.activate([
            emptyStateView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}
