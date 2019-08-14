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
    
    /// Configure the user's profileImage on the imageView
    ///
    /// - Parameter userImage:  The UIImage representing the users's Image
    func configureCell(userImage: UIImage?) {
        userImageView.image = userImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        userImageView.layer.masksToBounds = true
    }
}
