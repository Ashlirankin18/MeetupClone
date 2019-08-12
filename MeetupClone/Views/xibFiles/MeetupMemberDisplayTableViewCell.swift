//
//  MeetupMemberDisplayTableViewCell.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/8/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// `UITableViewCell` subclass which will display information pertaining to a member of a MeeetupGroup
final class MeetupMemberDisplayTableViewCell: UITableViewCell {

    @IBOutlet private weak var memberImageView: UIImageView!
    
    @IBOutlet private weak var memberNameLabel: UILabel!
    
    /// Hold the data and logic needed to populate the `MeetupMemberDisplayTableViewCell`
    struct ViewModel {
        let memberImageURL: URL?
        let memberName: String
    }
    
    /// The MeetupMemberTableViewCellViewModel
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            memberImageView.kf.setImage(with: viewModel.memberImageURL, placeholder: UIImage(named: "personPlaceholder"))
            memberNameLabel.text = viewModel.memberName
        }
    }
}
