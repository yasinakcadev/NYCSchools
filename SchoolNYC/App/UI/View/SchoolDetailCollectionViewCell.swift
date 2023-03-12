//
//  SchoolDetailCollectionViewCell.swift
//  SchoolNYC
//
//  Created by YASIN on 7.03.2023.
//

import UIKit
import PureLayout

class SchoolDetailCollectionViewCell: UICollectionViewCell {
    private var school: School?
    
    private struct Constant {
        static let borderWidth = 0.5
        static let cornerRadius = 10.0
        static let spacing = 5.0
        static let stackInset = 10.0
        static let wrapperInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private var addressTitleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.text = "Address"
        return label
    }()
    
    private var addressLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    private var emailTitleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.text = "Email"
        return label
    }()
    
    private var emailLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    private var phoneTitleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.text = "Phone"
        return label
    }()
    
    private var phoneLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    private var academicOpportunitiesTitleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.text = "Academic Opportunities"
        return label
    }()
    
    private var academicOpportunitiesLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    private var gradesTitleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.text = "Grades"
        return label
    }()
    
    private var gradesLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    private var websiteTitleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.text = "Website"
        return label
    }()
    
    private var websiteLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    private var wrapperView: UIView = {
       let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = Constant.borderWidth
        view.layer.cornerRadius = Constant.cornerRadius
        return view
    }()
    
    private var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.spacing = Constant.spacing
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
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
        setupStackView()
    }
    
    private func setupWrapperView() {
        addSubview(wrapperView)
        wrapperView.autoPinEdgesToSuperviewEdges(with: Constant.wrapperInset)
    }
    
    private func setupStackView() {
        wrapperView.addSubview(stackView)
        stackView.autoPinEdge(toSuperviewEdge: .top, withInset: Constant.stackInset)
        stackView.autoPinEdge(toSuperviewEdge: .leading, withInset: Constant.stackInset)
        stackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: Constant.stackInset)
        stackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: Constant.stackInset)
        
        stackView.addArrangedSubview(nameLabel)
        
        stackView.addArrangedSubview(addressTitleLabel)
        stackView.addArrangedSubview(addressLabel)
        
        stackView.addArrangedSubview(emailTitleLabel)
        stackView.addArrangedSubview(emailLabel)
        
        stackView.addArrangedSubview(phoneTitleLabel)
        stackView.addArrangedSubview(phoneLabel)
        
        stackView.addArrangedSubview(academicOpportunitiesTitleLabel)
        stackView.addArrangedSubview(academicOpportunitiesLabel)
        
        stackView.addArrangedSubview(gradesTitleLabel)
        stackView.addArrangedSubview(gradesLabel)
        
        stackView.addArrangedSubview(websiteTitleLabel)
        stackView.addArrangedSubview(websiteLabel)
    }
    
    func update(school: School) {
        self.school = school
        nameLabel.text = school.schoolName ?? "name"
        
        var fullAddress = ""
        var addressComponents: [String] = []
        
        if let city = school.city {
            addressComponents.append(city)
        }
        
        if let addressLine = school.primaryAddressLine {
            addressComponents.append(addressLine)
        }
        
        if let zipCode = school.zip {
            addressComponents.append(zipCode)
        }
        
        fullAddress = addressComponents.joined(separator: ", ")

        addressLabel.text = fullAddress
        emailLabel.text = school.schoolEmail ?? "Email"
        phoneLabel.text = school.phoneNumber ?? "Phone"
        
        var opportunities: [String] = []
        
        if let opportunities1 = school.academicOpportunities1 {
            opportunities.append(opportunities1)
        }
        
        if let opportunities2 = school.academicOpportunities1 {
            opportunities.append(opportunities2)
        }
        
        academicOpportunitiesLabel.text = opportunities.joined(separator: ", ")
        
        gradesLabel.text = school.finalgrades ?? "Grade"
        websiteLabel.text = school.website ?? "Website"
    }
}
