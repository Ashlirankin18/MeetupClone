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
        
        /// The date of the upcoming event
        let date: Date?
    }
    
    /// Represents the `GroupDisplayTableViewCell` Model
    var viewModel: ViewModel? {
        didSet {
            groupImageView.kf.setImage(with: self.viewModel?.groupImage, placeholder: UIImage(named: "placeholder"))
            let memberFormat = NSLocalizedString("%d Members", comment: "The people who are members of the group")
            let nextEventFormat = NSLocalizedString("Next Event: %@", comment: "The group's next event")
            groupNameLabel.text = self.viewModel?.groupName
            if let members = self.viewModel?.members,
                let nextEventName = self.viewModel?.nextEventName {
                nextEventLabel.isHidden = false
                nextEventLabel.text = "\(String.localizedStringWithFormat(memberFormat, members)) • \(String.localizedStringWithFormat(nextEventFormat, nextEventName)) \(convertDateToString(date: viewModel?.date))"
            } else {
                nextEventLabel.isHidden = true
            }
            groupImageView.isAccessibilityElement = true
            groupImageView.accessibilityLabel = NSLocalizedString("Group Display", comment: "Indicates to the user that this object displays an image ")
        }    
    }
    
    static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()
    
    private func convertDateToString(date: Date?) -> String {
        if let date = date {
            let format = NSLocalizedString("• %@", comment: "Seperator of information")
            return String.localizedStringWithFormat(format, GroupDisplayTableViewCell.dateFormatter.string(from: date))
        } else {
            return ""
        }
    }
    
    @IBOutlet private weak var groupImageView: UIImageView!
    @IBOutlet private weak var groupNameLabel: UILabel!
    @IBOutlet private weak var nextEventLabel: UILabel!
}
