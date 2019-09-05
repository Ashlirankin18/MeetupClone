//
//  IBDesignableRoundedButton.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 9/5/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// A representation of a button with rounded corners and a white border.
@IBDesignable
class RoundedButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 3
        layer.cornerRadius = 10
    }
}
