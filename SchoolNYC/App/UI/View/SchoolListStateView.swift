//
//  SchoolListStateView.swift
//  SchoolNYC
//
//  Created by YASIN on 12.03.2023.
//

import UIKit
import PureLayout

class SchoolListStateView: UIView {
    
    private struct Constants {
        static let headerLabelFont = 25.0
        static let messageLabelFont = 18.0
        static let spacing = 30.0
        static let labelWidth = 200.0
        static let stackInset = UIEdgeInsets(top: 200, left: 100, bottom: 200, right: 100)
        static let iconImageSize = CGSize(width: 200, height: 100)
    }

    private var headerLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.headerLabelFont)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.messageLabelFont)
        label.numberOfLines = 0
        return label
    }()
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func setupViews() {
        let stackView = UIStackView()
        stackView.spacing = Constants.spacing
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        addSubview(stackView)
        stackView.autoPinEdgesToSuperviewEdges(with: Constants.stackInset)
        
        stackView.addArrangedSubview(headerLabel)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(iconImageView)
        
        headerLabel.autoSetDimension(.width, toSize: Constants.labelWidth)
        messageLabel.autoSetDimension(.width, toSize: Constants.labelWidth)
        iconImageView.autoSetDimensions(to: Constants.iconImageSize)
    }
    
    func update(for state: SchoolListLoadState) {
        switch state {
        case .loaded:
            break
        case .error:
            headerLabel.text = "Error"
            messageLabel.text = "Scholl list didn't loaded"
        case .empty:
            headerLabel.text = "No schools are found"
            messageLabel.text = "Pull to refresh"
        }
    }
    
}
