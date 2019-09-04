//
//  EventsDisplayTableViewControllerDataSource.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/1/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// DataSource which will be used to manage data for the EventDisplayTableViewController.
final class EventsDisplayTableViewControllerDataSource: NSObject, UITableViewDataSource {
    
    /// Array of model objects that will be displayed on screen.
    var events = [MeetupEventModel]()
    
    private var showsEmptyState: Bool {
        return events.isEmpty
    }
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showsEmptyState ? 1 : events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if showsEmptyState {
            return tableView.dequeueEmptyStateCellAtIndexPath(cell: EmptyStateTableViewCell(), indexPath: indexPath, prompt: NSLocalizedString("This group has not upcoming events", comment: "Indicates to the user that there are no upcoming events"), image: UIImage.noEventsFound)
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventDisplayCell", for: indexPath) as? EventDisplayTableViewCell else {
                return UITableViewCell()
            }
            let event = events[indexPath.row]
            do {
                let description = try event.description?.asHTMLAttributedString()
                cell.viewModel = EventDisplayTableViewCell.ViewModel(eventName: event.eventName, eventDescription: description?.string ?? NSLocalizedString("This event does not have a description at this time", comment: "Lets the user know there is no current description for the event."), eventLocation: event.venue?.venueName ?? NSLocalizedString("This event does not have a location at this time", comment: "Lets the user know there is no current location for the event."), rsvpCount: event.yesRSVPCount)
            } catch {
                assertionFailure("Could not create NSAttributedString")
            }
            
            return cell
        }
    }
}
