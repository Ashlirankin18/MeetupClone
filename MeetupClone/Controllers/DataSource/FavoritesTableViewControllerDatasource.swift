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
        let favorites = PersistenceHelper.shared.retrieveFavoriteEventsFromDocumentsDirectory()
        if favorites.isEmpty {
            return 1
        } else {
            return PersistenceHelper.shared.retrieveFavoriteEventsFromDocumentsDirectory().count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let favorite = PersistenceHelper.shared.retrieveFavoriteEventsFromDocumentsDirectory()
        if favorite.isEmpty {
           let cell = tableView.dequeueEmptyStateCellAtIndexPath(cell: EmptyStateTableViewCell(), indexPath: indexPath, prompt: NSLocalizedString("You have not favorite events", comment: "Indicates to the user the have no favorite events"), image: UIImage.noFavoritesFound)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventDisplayCell", for: indexPath) as? EventDisplayTableViewCell else {
                return UITableViewCell()
            }
            let event =  PersistenceHelper.shared.retrieveFavoriteEventsFromDocumentsDirectory().reversed()[indexPath.row]
            do {
                let description = try event.description?.asHTMLAttributedString()
                cell.viewModel = EventDisplayTableViewCell.ViewModel(eventName: event.eventName, eventDescription: description?.string ?? NSLocalizedString("This event does not have a description", comment: "Informs the user the event has no description currently."), eventLocation: event.venue?.city, rsvpCount: event.yesRSVPCount)
            } catch {
                assertionFailure("Could not create NSAttributedString")
            }
            return cell
        }
    }
}
