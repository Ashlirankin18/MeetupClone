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
    
    /// Hold the data and logic needed to populate the `GroupDisplayTableViewCell`
    struct ViewModel {
        
        /// The name given to a MeetupGroup
        let groupName: String
        
        /// The imageURL of the group's profile image
        let groupImage: URL?
    }
    
    /// Represents the `GroupDisplayTableViewCell` Model
    var viewModel: ViewModel? {
        didSet {
            groupImageView.kf.setImage(with: viewModel?.groupImage)
        }
    }
    @IBOutlet private weak var groupImageView: UIImageView!
}
