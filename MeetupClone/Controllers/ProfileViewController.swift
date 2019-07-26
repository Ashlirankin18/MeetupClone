//
//  ProfileViewController.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// Displays the users profile information.
class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var profileControllerTableView: UITableView!
    
    private let meetupCloneDataSource = UserProfileDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProfileTableView()
    }
    
    private func setUpProfileTableView() {
        profileControllerTableView.delegate = self
        profileControllerTableView.dataSource = meetupCloneDataSource
        profileControllerTableView.rowHeight = UITableView.automaticDimension
        profileControllerTableView.estimatedRowHeight = 44
    }
}
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("UserImageView", owner: self, options: nil)?.first as? UserImageView else {
            return UIView() }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(300)
    }
}
