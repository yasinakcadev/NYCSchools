//
//  SATDetailCollectionViewCell.swift
//  SchoolNYC
//
//  Created by YASIN on 11.03.2023.
//

import UIKit
import PureLayout

class SATDetailCollectionViewCell: UICollectionViewCell {
    private var sat: SchoolSAT?
    
    private struct Constants {
        static let borderWidth = 0.5
        static let cornerRadius = 10.0
        static let spacing = 3.0
        static let wrapperInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        static let stackInset = 10.0
    }
    
    private var nottTitleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.text = "Number of Test Takers"
        return label
    }()
    
    private var nottLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 16)
         return label
    }()
    
    private var averageMathScoreTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.text = "Average Math Score"
        return label
    }()
    
    private var averageMathScoreLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private var averageCriticalReadingScoreTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.text = "Average Critical Reading Score"
        return label
    }()
    
    private var averageCriticalReadingScoreLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private var averageWritingTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.text = "Average Writing Score"
        return label
    }()
    
    private var averageWritingLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        return label
    }()
    
    private var wrapperView: UIView = {
       let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = Constants.borderWidth
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.spacing
        stackView.alignment = .fill
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeViews()
    }
    
    private func initializeViews() {
        setupWrapperView()
        setupStackView()
    }
    
    private func setupWrapperView() {
        addSubview(wrapperView)
        wrapperView.autoPinEdgesToSuperviewEdges(with: Constants.wrapperInset)
    }
    
    private func setupStackView() {
        wrapperView.addSubview(stackView)
        stackView.autoPinEdge(toSuperviewEdge: .leading,withInset: Constants.stackInset)
        stackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: Constants.stackInset)
        stackView.autoPinEdge(toSuperviewEdge: .top, withInset: Constants.stackInset)
        stackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: Constants.stackInset)
        
        stackView.addArrangedSubview(nottTitleLabel)
        stackView.addArrangedSubview(nottLabel)
        
        stackView.addArrangedSubview(averageMathScoreTitleLabel)
        stackView.addArrangedSubview(averageMathScoreLabel)
        
        stackView.addArrangedSubview(averageCriticalReadingScoreTitleLabel)
        stackView.addArrangedSubview(averageCriticalReadingScoreLabel)
        
        stackView.addArrangedSubview(averageWritingTitleLabel)
        stackView.addArrangedSubview(averageWritingLabel)
    }
    
    func update(sat: SchoolSAT) {
        self.sat = sat
        nottLabel.text = sat.numberOfSATTestTakers ?? "not label"
        averageMathScoreLabel.text = sat.mathAVGScore ?? "math label"
        averageCriticalReadingScoreLabel.text = sat.criticalReadingAVGScore ?? "reading label"
        averageWritingLabel.text = sat.writingAVGScore ?? "writing label"
    }
}
