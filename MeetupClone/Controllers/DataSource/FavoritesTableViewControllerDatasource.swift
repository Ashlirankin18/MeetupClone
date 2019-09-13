//
//  FavoritesTableViewControllerDatasource.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/13/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

///  DataSource which will be used to mage data for the FavoritesTableViewController.
final class FavoritesTableViewControllerDataSource: NSObject, UITableViewDataSource {

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let favorites = PersistenceHelper.shared.favoriteEvents
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favorites = PersistenceHelper.shared.favoriteEvents
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventDisplayCell", for: indexPath) as? EventDisplayTableViewCell else {
                return UITableViewCell()
            }
            let event = favorites[indexPath.row]
            do {
                let description = try event.description?.asHTMLAttributedString().string
                cell.viewModel = EventDisplayTableViewCell.ViewModel(eventName: event.eventName, eventDescription: description ?? NSLocalizedString("This event does not have a description", comment: "Informs the user the event has no description currently."), eventLocation: event.venue?.city, rsvpCount: event.yesRSVPCount)
            } catch {
                assertionFailure("Could not create NSAttributedString")
            }
            return cell
        }
    }
