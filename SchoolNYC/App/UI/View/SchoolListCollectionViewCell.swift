//
//  SchoolListCollectionViewCell.swift
//  SchoolNYC
//
//  Created by YASIN on 7.03.2023.
//

import UIKit
import PureLayout

class SchoolListCollectionViewCell: UICollectionViewCell {
    private var school: School?
    
    private struct Constants {
        static let borderWidth = 0.5
        static let borderRadius = 10.0
        static let labelWidth = 10.0
        static let wrapperInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        return label
    }()
    
    private var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        return label
    }()
    
    private var wrapperView: UIView = {
        let wrapperView = UIView()
        wrapperView.layer.borderColor = UIColor.gray.cgColor
        wrapperView.layer.borderWidth = Constants.borderWidth
        wrapperView.layer.cornerRadius = Constants.borderRadius
        return wrapperView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        setupWrapperView()
        setupNameLabel()
        setupCityLabel()
        setupEmailLabel()
    }
    
    
    private func setupWrapperView() {
        addSubview(wrapperView)
        wrapperView.autoPinEdgesToSuperviewEdges(with: Constants.wrapperInset)
    }
    
    private func setupNameLabel() {
        wrapperView.addSubview(nameLabel)
        nameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: Constants.labelWidth)
        nameLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: Constants.labelWidth)
        nameLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: Constants.labelWidth)
    }
    
    private func setupCityLabel() {
        wrapperView.addSubview(cityLabel)
        cityLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: Constants.labelWidth)
        cityLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: Constants.labelWidth)
        cityLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: Constants.labelWidth)
        
    }
    
    private func setupEmailLabel() {
        wrapperView.addSubview(emailLabel)
        emailLabel.autoPinEdge(.top, to: .bottom, of: cityLabel, withOffset: Constants.labelWidth)
        emailLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: Constants.labelWidth)
        emailLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: Constants.labelWidth)
        emailLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: Constants.labelWidth)
    }
    
    func populate(school: School) {
        self.school = school
        nameLabel.text = school.schoolName ?? "School name"
        cityLabel.text = school.city ?? "City"
        emailLabel.text = school.schoolEmail ?? "Email"
    }
    
    
    
}
