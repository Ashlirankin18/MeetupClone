//
//  EmptyStateView.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/27/19.
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
    
    private let emptyStatePromptLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let emptyStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "maleek-berry-sisi-maria-770x433")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        verticalStackView.addArrangedSubview(emptyStateImageView)
        verticalStackView.addArrangedSubview(emptyStatePromptLabel)
        addSubview(verticalStackView)
        setUpStackViewConstraints()
        backgroundColor = .groupTableViewBackground
    }
}
extension EmptyStateView {
    private func setUpStackViewConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            verticalStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            verticalStackView.widthAnchor.constraint(equalToConstant: 300)
            ])
    }
}
