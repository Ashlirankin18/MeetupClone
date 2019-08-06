//
//  GroupDisplayTableViewCell.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/26/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit
import Kingfisher
/// `UITableView` subclass which represents the information about a group object.
final class GroupDisplayTableViewCell: UITableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        groupImageView.image = nil
    }
    /// Hold the data and logic needed to populate the `GroupDisplayTableViewCell`
    struct ViewModel {
        
        /// The name given to a MeetupGroup
        let groupName: String
        
        /// The imageURL of the group's profile image
        let groupImage: URL?
       
        /// The number of people who are members of this group
        let members: Int
        
        /// The name of the group's mext event
        let nextEventName: String
    }
    
    /// Represents the `GroupDisplayTableViewCell` Model
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            groupImageView.kf.setImage(with: viewModel.groupImage, placeholder: UIImage(named: "group-placeholder") )
            groupNameLabel.text = viewModel.groupName
            nextEventLabel.text = "\(viewModel.members) Members • Next Event: \(String(describing: viewModel.nextEventName))"
        }
    }
    @IBOutlet private weak var groupImageView: UIImageView!
    @IBOutlet private weak var groupNameLabel: UILabel!
    @IBOutlet private weak var nextEventLabel: UILabel!
}
