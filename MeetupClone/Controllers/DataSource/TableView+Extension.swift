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
    ///   - indexPath: <#indexPath description#>
    ///   - prompt: <#prompt description#>
    ///   - image: <#image description#>
    /// - Returns: <#return value description#>
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
