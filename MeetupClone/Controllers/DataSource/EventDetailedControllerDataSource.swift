//
//  EventDetailedControllerDataSource.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/8/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// DataSource which will be used to mage data for the EventDetailedTableViewController.
final class EventDetailedControllerDataSource: NSObject, UITableViewDataSource {
    var items: [MeetupRSVPModel] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as? MeetupMemberDisplayTableViewCell else {
            return UITableViewCell()
        }
        let rsvp = items[indexPath.row]
        cell.viewModel = MeetupMemberDisplayTableViewCell.ViewModel(memberImageURL: rsvp.member?.photo?.thumbLink, memberName: rsvp.member?.name ?? "No name")
        return cell
    }
}
