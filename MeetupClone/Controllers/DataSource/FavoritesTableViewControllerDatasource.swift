//
//  FavoritesTableViewControllerDatasource.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/13/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

final class FavoritesTableViewControllerDatasource: NSObject, UITableViewDataSource {
    
    var favoriteEvents = [FavoriteEventsModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventDisplayCell", for: indexPath) as? EventDisplayTableViewCell else {
            return UITableViewCell()
        }
        let event = favoriteEvents[indexPath.row]
        cell.viewModel = EventDisplayTableViewCell.ViewModel(eventName: event.eventName, eventDescription: event.description ?? NSLocalizedString("This event does not have a description", comment: "Informs the user the event has no description currently."), eventLocation: event.eventCity, rsvpCount: event.rsvpCount)
        return cell
    }
}
