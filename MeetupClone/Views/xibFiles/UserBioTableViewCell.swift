//
//  UserBioTableViewCell.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/24/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// Represents the cell that will display the user's bio information.
final class UserBioTableViewCell: UITableViewCell {

    struct ViewModel {
        let bio: String?
    }
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            if let userBio = viewModel.bio {
                bioDisplayTextView.text = userBio
            } else {
                bioDisplayTextView.text = NSLocalizedString("You have no bio", comment: "Indicates to the user they have no bio")
            }
        }
    }
    
    @IBOutlet private weak var bioDisplayNameLabel: UILabel!
    @IBOutlet private weak var bioDisplayTextView: UITextView!
}
