//
//  EmptyStateView.swift
//  MeetupClone
//
//  Created by Ashli Rankin on 8/27/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {
    /// Manages the data that is needed to populate the `EmptyStateView`
    struct ViewModel {
        
        /// The image that will be displayed on the cell
        let emptyStateImage: UIImage?
        
        /// The prompt that will be displayed on the cell
        let emptyStatePrompt: String
    }
    lazy var emptyStatePromptLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    lazy var emptyStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var viewModel: ViewModel? {
        didSet {
            emptyStateImageView.image = viewModel?.emptyStateImage
            emptyStatePromptLabel.text = viewModel?.emptyStatePrompt
        }
    }
    
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
    }
}
extension EmptyStateView {
    private func setUpStackViewConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            verticalStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            verticalStackView.widthAnchor.constraint(equalToConstant: 200),
            verticalStackView.heightAnchor.constraint(equalToConstant: 200)
            ])
    }
}
