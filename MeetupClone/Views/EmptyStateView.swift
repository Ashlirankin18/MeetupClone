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
        label.backgroundColor = .groupTableViewBackground
        label.text = "Label"
        label.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var emptyStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "maleek-berry-sisi-maria-770x433")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.spacing = 20
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
        backgroundColor = .groupTableViewBackground
    }
}
extension EmptyStateView {
    private func setUpStackViewConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            verticalStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            verticalStackView.widthAnchor.constraint(equalToConstant: 300),
            verticalStackView.heightAnchor.constraint(equalToConstant: 150)
            ])
    }
}
