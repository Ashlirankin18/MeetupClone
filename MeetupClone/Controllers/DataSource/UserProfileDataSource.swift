//
//  UserProfileDataSource.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/24/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// Represents the dataSource used to configure the tableView in the ProfileViewController 
final class UserProfileDataSource: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0, 1 :
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "UserInfoCell")
            cell.textLabel?.text = NSLocalizedString("Name", comment: "Username")
            cell.detailTextLabel?.text = NSLocalizedString("Ashli", comment: "Actual Name")
            return cell

        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserBioCell", for: indexPath) as? UserBioTableViewCell else {
                return UITableViewCell() }
            return cell
        }
    }
}
