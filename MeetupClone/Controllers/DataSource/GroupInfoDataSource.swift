//
//  GroupInfoDataSource.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/26/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// DataSource which will be used to mage data for the groupDisplayTableView.
final class GroupInfoDataSource: NSObject, UITableViewDataSource {
    
    var groups = [MeetupGroupModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupDisplayCell", for: indexPath) as? GroupDisplayTableViewCell else {
            fatalError("Could not dequeue cell at indexPath.")
        }
        guard !groups.isEmpty else { fatalError("No groups could be found.") }
        let group = groups[indexPath.row]
        cell.viewModel = GroupDisplayTableViewCell.ViewModel(groupName: group.groupName, groupImage: group.groupPhoto?.photoLink, members: group.members, nextEventName: group.nextEvent?.eventName ?? NSLocalizedString("This group has no upcoming Events", comment: "Describes the group's upcoming events"))
        return cell
    }
}
