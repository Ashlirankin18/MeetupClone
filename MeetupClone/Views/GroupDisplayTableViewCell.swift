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
class GroupDisplayTableViewCell: UITableViewCell {
    @IBOutlet private weak var groupNameLabel: UILabel!
    @IBOutlet private  weak var groupImageView: UIImageView!
    @IBOutlet private weak var groupCapacityLabel: UILabel!
    @IBOutlet private weak var upcomingEventLabel: UILabel!
    
    /// Configures the GroupDisplayTableViewCell
    ///
    /// - Parameter meetupGroup: object representing a group Model
    func configureView(meetupGroup: MeetupGroupModel) {
        groupNameLabel.text = meetupGroup.groupName
        groupImageView.kf.setImage(with: meetupGroup.photo.highresLink, placeholder: UIImage(named: "placeholder"))
    }
}
