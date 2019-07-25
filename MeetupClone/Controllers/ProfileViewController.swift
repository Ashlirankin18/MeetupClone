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
        profileControllerTableView.dataSource = dataSource
        profileControllerTableView.rowHeight = UITableView.automaticDimension
        profileControllerTableView.estimatedRowHeight = 6000
    }
}
