//
//  SchoolDetailMapCollectionViewCell.swift
//  SchoolNYC
//
//  Created by YASIN on 12.03.2023.
//

import UIKit
import MapKit
import PureLayout

class SchoolDetailMapCollectionViewCell: UICollectionViewCell {
    private var school: School?
    
    private struct Constants {
        static let borderWidth = 0.5
        static let cornerRadius = 10.0
        static let wrapperInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    private var mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    private var wrapperView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = Constants.borderWidth
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupWrapperView() {
        addSubview(wrapperView)
        wrapperView.autoPinEdgesToSuperviewEdges(with: Constants.wrapperInset)
    }
    
    private func setupViews() {
        setupWrapperView()
        backgroundColor = .white
        
        wrapperView.addSubview(mapView)
        mapView.autoPinEdgesToSuperviewEdges()
        mapView.delegate = self
        wrapperView.clipsToBounds = true
    }
    
    func populate(school: School) {
        self.school = school
        if let latitude = school.latitude,
           let latitudeDouble = Double(latitude),
           let longitude = school.longitude,
           let longitudeDouble = Double(longitude) {
            let coordinate = CLLocationCoordinate2D(latitude: latitudeDouble, longitude: longitudeDouble)
            let anotation = SchoolMapAnotation(title: school.schoolName ?? "school_name", coordinate: coordinate, subtitle: school.primaryAddressLine ?? "adress_line")
            mapView.addAnnotation(anotation)
            
            if let regionMeters = CLLocationDistance(exactly: 6000) {
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
                mapView.setRegion(mapView.regionThatFits(region), animated: true)
            }
        }
    }
    
}

extension SchoolDetailMapCollectionViewCell: MKMapViewDelegate {
    
}
