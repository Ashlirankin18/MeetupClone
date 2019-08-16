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
    
    @IBOutlet private weak var userImageView: UIImageView!
    
    struct ViewModel {
        let userImageLink: URL?
    }
    
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            userImageView.kf.setImage(with: viewModel.userImageLink)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
         userImageView.layer.cornerRadius = userImageView.frame.width / 2
        userImageView.layer.masksToBounds = true
    }
}
