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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProfileTableView()
        retrieveUserInformation()
    }
    
    private var meetupUserModel: MeetupUserModel?
    
    private func setUpProfileTableView() {
        profileControllerTableView.delegate = self
        profileControllerTableView.dataSource = meetupCloneDataSource
        profileControllerTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func retrieveUserInformation() {
        meetupDatatHandler.retrieveUserData { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let userInfo):
                self.meetupUserModel = userInfo
                self.meetupCloneDataSource.meetupUserModel = userInfo
                self.profileControllerTableView.reloadData()
            }
        }
    }
}
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("UserImageView", owner: self, options: nil)?.first as? UserImageView else {
            return UIView() }
        guard let meetupUserModel = meetupUserModel else {
            return UIView()
        }
        headerView.viewModel = UserImageView.ViewModel(userImageLink: meetupUserModel.photo?.highresLink)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
}
