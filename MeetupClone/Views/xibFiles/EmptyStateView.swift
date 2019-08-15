//
//  EmptyStateView.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/15/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// 'UIView' subclass which will display a prompt to the user if the object array is empty.
final class EmptyStateView: UIView {

    /// Manages the data that is needed to populate the `EmptyStateView`
    struct ViewModel {
        
        /// The display image
        let image: UIImage
        
        /// The prompt shown when there are no results
        let prompt: String
    }
    
    @IBOutlet private weak var emptyStateImage: UIImageView!
    
    @IBOutlet private weak var emptyStatePrompt: UILabel!
    
    /// Represents the `EmptyStateView`'s model
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                assertionFailure("No viewModel was found")
                return
            }
            emptyStateImage.image = viewModel.image
            emptyStatePrompt.text = viewModel.prompt
        }
    }
}
