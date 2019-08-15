//
//  TableView+Extension.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/15/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

// MARK: - UITableViewExtension shows or  removes an emptyStateView if the is data.
extension UITableView {
    
    /// Configures the tableView's background view to display an emptyStateView if there are no cells.
    ///
    /// - Parameters:
    ///   - image: The image which will be shown.
    ///   - prompt: The prompty to the user if there are no items found.
    func setupEmptyStateView(image: UIImage?, prompt: String) {
        guard let emptyStateView = Bundle.main.loadNibNamed("EmptyStateView", owner: self, options: nil)?.first as? EmptyStateView,
            let image = image else {
                assertionFailure("Could not load nib or find an image")
                return
        }
        emptyStateView.frame = CGRect(x: 0, y: 0, width: frame.height, height: frame.width)
        emptyStateView.viewModel = EmptyStateView.ViewModel(image: image, prompt: prompt)
        backgroundView = emptyStateView
        separatorStyle = .none
    }
    
    /// Removes the backgroundView and return the seperator style
    func restoreView() {
        backgroundView = nil
        separatorStyle = .singleLine
    }
}
