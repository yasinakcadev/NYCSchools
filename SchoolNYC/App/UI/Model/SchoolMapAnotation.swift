//
//  SchoolMapAnotation.swift
//  SchoolNYC
//
//  Created by YASIN on 12.03.2023.
//

import Foundation
import MapKit

class SchoolMapAnotation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var subtitle: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D, subtitle: String) {
        self.title = title
        self.coordinate = coordinate
        self.subtitle = subtitle
    }
}
