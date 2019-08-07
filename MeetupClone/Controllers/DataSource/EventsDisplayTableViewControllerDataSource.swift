//
//  EventsDisplayTableViewControllerDataSource.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/1/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

class EventsDisplayTableViewControllerDataSource: NSObject, UITableViewDataSource {
    
    //NOTE this will be changed to even once the network Login Pull Request becomes approved
    var items = [MeetupEventModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventDisplayCell", for: indexPath) as? EventDisplayTableViewCell else {
            return UITableViewCell()
        }
        let event = items[indexPath.row]
        cell.viewModel = EventDisplayTableViewCell.ViewModel(eventName: event.eventName, eventDescription: event.description ?? NSLocalizedString("This event does not have a description at this time", comment: "Lets the user no the event has not description."), eventLocation: event.venue?.venueName ?? NSLocalizedString("This event does not have a locationat this time", comment: "Lets the user know there is no current location for the event."), rsvpCount: event.yesRSVPCount)
        return cell
    }
}
