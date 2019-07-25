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
    
    let dataSource = MeetUpCloneDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileControllerTableView.delegate = self
        profileControllerTableView.dataSource = dataSource
        profileControllerTableView.rowHeight = UITableView.automaticDimension
        profileControllerTableView.estimatedRowHeight = 6000
    }
}
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("UserImageView", owner: self, options: nil)?.first as? UserImageView else {
            return UIView() }
        headerView.backgroundColor = .black
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
}
