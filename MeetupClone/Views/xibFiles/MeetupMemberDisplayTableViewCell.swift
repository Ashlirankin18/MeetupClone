//
//  MeetupMemberDisplayTableViewCell.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/8/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// `UITableViewCell` subclass which will display information pertaining to a member of a MeetupGroup
final class MeetupMemberDisplayTableViewCell: UITableViewCell {
    
    /// Hold the data and logic needed to populate the `MeetupMemberDisplayTableViewCell`
    struct ViewModel {
        
        /// The URL the hold the information to the image of a member of a group
        let memberImageURL: URL?
        
        /// The name of the member of the group
        let memberName: String?
    }
    
    /// The MeetupMemberTableViewCellViewModel
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            memberImageView.kf.setImage(with: viewModel.memberImageURL, placeholder: UIImage(named: "personPlaceholder"))
            memberNameLabel.text = viewModel.memberName?.capitalized
        }
    }
    
    @IBOutlet private weak var memberImageView: UIImageView!
    
    @IBOutlet private weak var memberNameLabel: UILabel!
}
