//
//  UIViewControllerExtension.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/28/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Constrains a give view to the view controller view
    ///
    /// - Parameter view: View that will be constrained to the viewController's view.
    func constrainViewToScreen(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
    }
}
