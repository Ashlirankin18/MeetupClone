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
}
