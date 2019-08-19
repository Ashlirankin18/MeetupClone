//
//  IBDesignableImageView.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/13/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// A representation of a circular ImageView. 
@IBDesignable
class CircularImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        contentMode = .scaleAspectFill
        layer.cornerRadius = bounds.width / 2.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        clipsToBounds = true
    }
}
