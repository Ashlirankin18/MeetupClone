//
//  EventDisplayTableViewCell.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/1/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// `UITableViewCell` subclass which represents the information about a group object.
final class EventDisplayTableViewCell: UITableViewCell {
   
    /// Hold the data and logic needed to populate the `EventDisplayTableViewCell`
    struct ViewModel {
        
        /// The name of the event
        let eventName: String
        
        /// The event's description
        let eventDescription: String
        
        /// The location of the event
        let eventLocation: String
        
        /// The number of person's who replied yes to the event.
        let rsvpCount: Int
    }
    
    /// The cell's view model
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            let locationFormat = NSLocalizedString("Event Location: %@", comment: "The location of an event")
            let rsvpFormat = NSLocalizedString("Number of persons Attending: %d", comment: "Indicates to the user how many persons are attending an event")
            eventNameLabel.text = viewModel.eventName
            eventDescriptionTextView.text = viewModel.eventDescription
            eventLocationLabel.text = String.localizedStringWithFormat(locationFormat, viewModel.eventLocation)
            rsvpLabel.text = String.localizedStringWithFormat(rsvpFormat, viewModel.rsvpCount)
        }
    }
    @IBOutlet private weak var eventNameLabel: UILabel!
    @IBOutlet private weak var eventDescriptionTextView: UITextView!
    @IBOutlet private weak var eventLocationLabel: UILabel!
    @IBOutlet private weak var rsvpLabel: UILabel!
}
