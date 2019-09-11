//
//  RoundedButton.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 9/5/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// A representation of a button with rounded corners and a white border.
@IBDesignable
class RoundedButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProterties()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupProterties()
    }
    
    private func setupProterties() {
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 10
    }
}
