//
//  UserBioTableViewCell.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/24/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

class UserBioTableViewCell: UITableViewCell {

    @IBOutlet private weak var bioDisplayTextVIew: UITextView!
    
    func configureCell() {
        self.bioDisplayTextVIew.text = """
        Hello my name is Ashli Hello my name is Ashli Hello my name is Ashli
         Hello my name is Ashli Hello my name is Ashli Hello my name is Ashli
         Hello my name is Ashli Hello my name is Ashli Hello my name is Ashli
         Hello my name is Ashli Hello my name is Ashli Hello my name is Ashli Hello my name is Ashli
        """
    }
}
