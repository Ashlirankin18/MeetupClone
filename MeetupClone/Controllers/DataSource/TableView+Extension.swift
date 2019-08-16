//
//  TableView+Extension.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/16/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Responsible for dequeueing an emptyStateCell
    ///
    /// - Parameters:
    ///   - cell: `UITableView` subclass which 
    ///   - indexPath: The indexPath where the cell will be dequeued
    ///   - prompt: The prompt that will be displayed to the user
    ///   - image: The image whicch will be displayed on the cell
    /// - Returns: The configured tableView Cell
    func dequeueEmptyStateCellAtIndexPath(cell: EmptyStateTableViewCell, indexPath: IndexPath, prompt: String, image: UIImage?) -> UITableViewCell {
        guard let cell = self.dequeueReusableCell(withIdentifier: "EmptyStateCell", for: indexPath) as? EmptyStateTableViewCell,
        let image = image else {
            return UITableViewCell()
        }
        
        cell.viewModel = EmptyStateTableViewCell.ViewModel(emptyStateImage: image, emptyStatePrompt: prompt)
        cell.isUserInteractionEnabled = false
        self.separatorStyle = .none
        return cell
    }
}
