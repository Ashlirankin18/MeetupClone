//
//  EmptyStateViewController.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 7/26/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// A 'UIViewController' subclass that represents the empty states the application may have.
class EmptyStateViewController: UIViewController {
    
    @IBOutlet private weak var promptButton: UIButton!
    
    /// Initilizes the EmptyStateViewController with a tilte for the emptyState prompt.
    ///
    /// - Parameter primaryTitle: The title which will be given to the prompt button.
    init(primaryTitle: String) {
        super.init(nibName: nil, bundle: nil)
        promptButton.setTitle(primaryTitle, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
