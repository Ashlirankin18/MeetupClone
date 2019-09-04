//
//  EmptyStateTableViewCell.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/16/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// `UITableViewCell` subclass which will display a prompt to the user if the object array is empty.

class EmptyStateTableViewCell: UITableViewCell {
    
    /// Manages the data that is needed to populate the `EmptyStateTableViewCell`
    struct ViewModel {
        
        /// The image that will be displayed on the cell
        let emptyStateImage: UIImage?
        
        /// The prompt that will be displayed on the cell
        let emptyStatePrompt: String
    }
    
    /// Represents the `EmptyStateTableViewCell`'s model
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            emptyStateImageView.image = viewModel.emptyStateImage
            emptyStatePromptLabel.text = viewModel.emptyStatePrompt
        }
    }
  
    @IBOutlet private weak var emptyStateImageView: UIImageView!
    @IBOutlet private weak var emptyStatePromptLabel: UILabel!
}
