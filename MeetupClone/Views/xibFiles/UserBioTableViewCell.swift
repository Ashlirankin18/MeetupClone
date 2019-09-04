//
//  UserBioTableViewCell.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/24/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// `UITableViewCell` subclass representing the cell that will display the user's bio information.
final class UserBioTableViewCell: UITableViewCell {
    
    /// Holds the data and logic needed to populate the `UserBioTableViewCell`
    struct ViewModel {
        let bio: String?
    }
    
    /// Represents the `UserBioTableViewCell` model
    var viewModel: ViewModel? {
        didSet {
            if let userBio = viewModel?.bio {
                bioDisplayTextView.text = userBio
            } else {
                bioDisplayTextView.text = NSLocalizedString("You have no bio", comment: "Indicates to the user they have no bio")
            }
        }
    }
    
    @IBOutlet private weak var bioDisplayTextView: UITextView!
}
