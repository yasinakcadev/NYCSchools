//
//  SchoolSectionHeader.swift
//  SchoolNYC
//
//  Created by YASIN on 7.03.2023.
//

import UIKit
import PureLayout

class SchoolSectionHeader: UICollectionReusableView {
    private struct Constants {
        static let edgeInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    var headerLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupViews() {
        addSubview(headerLabel)
        headerLabel.autoPinEdgesToSuperviewEdges(with: Constants.edgeInset)
    }
}
