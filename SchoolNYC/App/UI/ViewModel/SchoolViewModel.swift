//
//  SchoolViewModel.swift
//  SchoolNYC
//
//  Created by YASIN on 7.03.2023.
//

import Foundation
import Combine

class SchoolViewModel {
    @Published private(set) var schools: [School]?
    @Published private(set) var error: Error? = nil
    @Published private(set) var sats: [SchoolSAT]?
    
    private(set) var schoolSectionList: [SchoolSection]?
    private(set) var satDictionary: [String: SchoolSAT] = [:]
    
    private let api: SchoolAPIDirectory
    
    init(api: SchoolAPIDirectory = SchoolAPI()) {
        self.api = api
    }
    
    func getSchools() {
        api.getSchools {[weak self] result in
            switch result {
            case .failure(let error):
                self?.error = error
            case .success(let schools):
                self?.schools = schools ?? []
                if schools?.isEmpty == false {
                    self?.prepareForSection()
                }
            }
        }
    }
    
    func getSchoolSats() {
        sats?.removeAll()
        api.getSchoolSats {[weak self] result in
            switch result {
            case .failure(let error):
                self?.error = error
            case .success(let schoolSats):
                self?.sats = schoolSats
                
                for sat in schoolSats {
                    self?.satDictionary[sat.dbn] = sat
                }
            }
        }
    }
    
    func prepareForSection() {
        var listOfSections = [SchoolSection]()
        var schoolDictionary = [String : SchoolSection]()
        
        if let schools = schools {
            for school in schools {
                if let city = school.city {
                    if schoolDictionary[city] != nil {
                        schoolDictionary[city]?.schools.append(school)
                    }else {
                        var newSection = SchoolSection(city: city, schools: [])
                        newSection.schools.append(school)
                        schoolDictionary[city] = newSection
                    }
                }
            }
        }
        
        
        listOfSections = Array(schoolDictionary.values)
        listOfSections.sort {
            return $0.city < $1.city
        }
        
        schoolSectionList = listOfSections
    }
}
