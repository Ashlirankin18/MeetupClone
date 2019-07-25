//
//  UserImageView.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/25/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

class UserImageView: UIView {
    
    @IBOutlet private weak var userImageView: UIImageView!
    
    func configureCell(userImage: UIImage) {
        userImageView.image = userImage
    }
}
