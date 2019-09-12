//
//  UserNameTableViewCell.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 9/11/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// `UITableViewCell` subclass which will display the user's name
final class UserNameTableViewCell: UITableViewCell {

    /// Manages the data that is needed to populate the `UserNameTableViewCell`
    struct ViewModel {
        
        /// The user's name.
        let userName: String
    }
    
    ///  Represents the `UserNameTableViewCell`'s model
    var viewModel: ViewModel? {
        didSet {
            userNameLabel.text = viewModel?.userName
        }
    }
    
    @IBOutlet private weak var userNameLabel: UILabel!
}
