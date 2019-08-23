//
//  EventDetailedControllerDataSource.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/8/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// DataSource which will be used to manage data for the EventDetailedTableViewController.
final class EventDetailedControllerDataSource: NSObject, UITableViewDataSource {
    
    /// An Array of model objects the will be displayed on screen.
    var rsvps: [MeetupRSVPModel] = []
    
    private var shouldDisplayEmptyStateCell: Bool {
        return rsvps.isEmpty
    }
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shouldDisplayEmptyStateCell ? 1: rsvps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if shouldDisplayEmptyStateCell {
            let cell = tableView.dequeueEmptyStateCellAtIndexPath(cell: EmptyStateTableViewCell(), indexPath: indexPath, prompt: NSLocalizedString("You are not a member of this group", comment: "Indicates to the user that they are not a member of the group"), image: UIImage.notAGroupMember)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as? MeetupMemberDisplayTableViewCell else {
                return UITableViewCell()
            }
            guard rsvps.indices.contains(indexPath.row) else {
                assertionFailure("RSVP Array does not contain the specified index")
                return UITableViewCell()
            }
            let rsvp = rsvps[indexPath.row]
            cell.viewModel = MeetupMemberDisplayTableViewCell.ViewModel(memberImageURL: rsvp.member.photo?.photoLink, memberName: rsvp.member.name)
            return cell
        }
    }
}
