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
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rsvps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
