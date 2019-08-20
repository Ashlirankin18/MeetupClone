//
//  GroupDisplayTableViewCell.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/26/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit
import Kingfisher

/// `UITableViewCell` subclass which represents the information about a group object.
final class GroupDisplayTableViewCell: UITableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        groupImageView.image = nil
    }
    /// Holds the data and logic needed to populate the `GroupDisplayTableViewCell`
    struct ViewModel {
        
        /// The name given to a MeetupGroup
        let groupName: String
        
        /// The imageURL of the group's profile image
        let groupImage: URL?
        
        /// The number of people who are members of this group
        let members: Int?
        
        /// The name of the group's mext event
        let nextEventName: String?
    }
    
    /// Represents the `GroupDisplayTableViewCell` Model
    var viewModel: ViewModel? {
        didSet {
            groupNameLabel.text = viewModel?.groupName
            groupImageView.kf.setImage(with: viewModel?.groupImage, placeholder: UIImage(named: "group-placeholder"))
            checkForEventsInformationAndSetsLabel(viewModel: viewModel)
        }
    }
    
    private func checkForEventsInformationAndSetsLabel(viewModel: ViewModel?) {
        let memberFormat = NSLocalizedString("%d Members", comment: "The people who are members of the group")
        let nextEventFormat = NSLocalizedString("Next Event: %@ ", comment: "The group's next event")
        nextEventLabel.isHidden = false
        if let members = viewModel?.members,
            let nextEventName = viewModel?.nextEventName {
            nextEventLabel.text = "\(String.localizedStringWithFormat(memberFormat, members))  •  \(String.localizedStringWithFormat(nextEventFormat, nextEventName))"
        } else {
            nextEventLabel.isHidden = true
        }
    }
    @IBOutlet private weak var groupImageView: UIImageView!
    @IBOutlet private weak var groupNameLabel: UILabel!
    @IBOutlet private weak var nextEventLabel: UILabel!
    @IBOutlet private weak var tintedView: UIView!
}
