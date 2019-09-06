//
//  EmptyStateView.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 9/2/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// `UIView` subclass which contains the information needed to display an empty state to the user.
final class EmptyStateView: UIView {
    /// Manages the data that is needed to populate the `EmptyStateView`
    struct ViewModel {
        
        /// The image that will be displayed on the view
        let emptyStateImage: UIImage?
        
        /// The prompt that will be displayed on the view

        let emptyStatePrompt: String
    }
    
    /// The `EmptyStateView`'s viewModel
    var viewModel: ViewModel? {
        didSet {
            emptyStateImageView.image = viewModel?.emptyStateImage
            emptyStatePromptLabel.text = viewModel?.emptyStatePrompt
        }
    }
    
    @IBOutlet private weak var emptyStateImageView: UIImageView!
    @IBOutlet private weak var emptyStatePromptLabel: UILabel!
}
