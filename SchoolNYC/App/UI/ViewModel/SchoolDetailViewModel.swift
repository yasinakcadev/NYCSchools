//
//  SchoolDetailViewModel.swift
//  SchoolNYC
//
//  Created by YASIN on 8.03.2023.
//

import Foundation

class SchoolDetailViewModel {
    private(set) var school: School
    private(set) var schoolSAT: SchoolSAT
    
    init(school: School, schoolSAT: SchoolSAT) {
        self.school = school
        self.schoolSAT = schoolSAT
    }
}
