//
//  EventDisplayTableViewCell.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/1/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

class EventDisplayTableViewCell: UITableViewCell {
    @IBOutlet private weak var eventNameLabel: UILabel!
    @IBOutlet private weak var eventDescriptionTextView: UITextView!
    @IBOutlet private weak var eventLocationLabel: UILabel!
    @IBOutlet private weak var rsvpLabel: UILabel!
    
    struct ViewModel {
        let eventName: String
        let eventDescription: String
        let eventLocation: String
        let rsvpCount: Int
    }
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            eventNameLabel.text = viewModel.eventName
            eventDescriptionTextView.text = viewModel.eventDescription
            eventLocationLabel.text = viewModel.eventLocation
            rsvpLabel.text = "\(viewModel.rsvpCount)"
        }
    }    
}
