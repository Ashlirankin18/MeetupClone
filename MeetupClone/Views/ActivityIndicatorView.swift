//
//  ActivityIndicatorView.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/27/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

/// A `UIView` Subclass which represents a view of an activity indicator
final class ActivityIndicatorView: UIView {
    
    /// Indicator view which will be displayed when network data is being retrieved.
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = #colorLiteral(red: 0.9980096221, green: 0.005193474237, blue: 0.1327431798, alpha: 0.9240757042)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    var isAnimating = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(activityIndicatorView)
        setUpActivityIndicatorConstraints()
        backgroundColor = .groupTableViewBackground
        isAnimating = activityIndicatorView.isAnimating
    }
    
    func indicatorStartAnimating() {
        activityIndicatorView.startAnimating()
    }
    
    func indicatorStopAnimating() {
        activityIndicatorView.stopAnimating()
    }
}
extension ActivityIndicatorView {
    private func setUpActivityIndicatorConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
}
