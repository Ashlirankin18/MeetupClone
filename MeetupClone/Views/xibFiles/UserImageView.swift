//
//  UserImageView.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/25/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// Represent the users Profile Image.
final class UserImageView: UIView {
    
    
    
    /// Holds the data needed to populate `UserImageView`
    struct ViewModel {
        let userImageLink: URL?
    }
    
    /// Represents the `UserImageView` model
    var viewModel: ViewModel? {
        didSet {
            userImageView.kf.setImage(with: viewModel?.userImageLink)
        }
    }
    @IBOutlet private weak var userImageView: UIImageView!
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        userImageView.layer.masksToBounds = true
    }
}
