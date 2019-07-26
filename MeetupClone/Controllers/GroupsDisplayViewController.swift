//
//  GroupsDisplayViewController.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/23/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// Display a list of groups that the user searches for.
class GroupsDisplayViewController: UIViewController {

    @IBOutlet private weak var groupDisplayTableView: UITableView!
    
    private let groupInfoDataSource = GroupInfoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupDisplayTableView.dataSource = groupInfoDataSource
        groupDisplayTableView.rowHeight = UITableView.automaticDimension
        groupDisplayTableView.estimatedRowHeight = 44
    }
}
