//
//  MeetUpCloneDataSource.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/24/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

class MeetUpCloneDataSource: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0, 1 :
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "UserInfoCell")
            cell.textLabel?.text = "Ashli"
            cell.detailTextLabel?.text = "Hello"
            return cell
        case 2 :
            let cell = UITableViewCell(style: .default, reuseIdentifier: "BioDisplayCell")
            cell.textLabel?.text = "Bio:"
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserBioCell", for: indexPath) as? UserBioTableViewCell else {
                return UITableViewCell() }
            cell.configureCell()
            return cell
        }
    }
}
