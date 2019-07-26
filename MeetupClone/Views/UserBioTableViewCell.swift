//
//  UserBioTableViewCell.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/24/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// Represents the cell that will display the user's bio information.
class UserBioTableViewCell: UITableViewCell {

    @IBOutlet private weak var bioDisplayTextView: UITextView!
    
    /// Configure the textView with text.
    func configureCell(userBio: String) {
        self.bioDisplayTextView.text = userBio
    }
}
