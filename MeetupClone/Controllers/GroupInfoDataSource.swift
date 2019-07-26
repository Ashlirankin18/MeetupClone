//
//  GroupInfoDataSource.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/26/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// DataSource which will be used to mage data for the groupDisplayTableView.
class GroupInfoDataSource: NSObject, UITableViewDataSource {
    
    private let groups = [MeetupGroupModel]() 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupDisplayCell", for: indexPath) as? GroupDisplayTableViewCell else {
            fatalError("Could not dequeue cell at indexPath")
             }
        guard groups.isEmpty  else {
            let cell = UITableViewCell()
            cell.backgroundColor = .red
            return cell
        }
        let group = groups[indexPath.row]
        cell.configureView(meetupGroup: group)
        return cell
    }
}
