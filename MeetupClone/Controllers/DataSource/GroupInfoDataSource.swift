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
    
    /// Array of model objects that will be displayed on screen.
    var groups = [MeetupGroupModel]()
    
    private var showsEmptyState: Bool {
        return groups.isEmpty
    }
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showsEmptyState ? 1 : groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if showsEmptyState {
            return tableView.dequeueEmptyStateCellAtIndexPath(cell: EmptyStateTableViewCell(), indexPath: indexPath, prompt: NSLocalizedString("No groups were found, try searching for your interest", comment: "Indicates to the user no groups were found"), image: UIImage.noGroupsFound)
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupDisplayCell", for: indexPath) as? GroupDisplayTableViewCell else {
                fatalError("Could not dequeue cell at indexPath.")
            }
            let group = groups[indexPath.row]
            cell.viewModel = GroupDisplayTableViewCell.ViewModel(groupName: group.groupName, groupImage: group.groupPhoto?.photoLink, members: group.members, nextEventName: group.nextEvent?.eventName ?? NSLocalizedString("This group has no upcoming Events", comment: "Describes the group's upcoming events"), date: group.nextEvent?.time)
            return cell
        }
    }
}
