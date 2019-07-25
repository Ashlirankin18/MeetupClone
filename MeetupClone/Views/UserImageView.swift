//
//  UserImageView.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/25/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

class UserImageView: UIView {

    @IBOutlet private var userImageViewContainerView: UIView!
    @IBOutlet private weak var userImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        commonInit()
    }
    
   private func commonInit() {
        Bundle.main.loadNibNamed("UserImageView", owner: self, options: [:])
        addSubview(userImageViewContainerView)
    }
}
