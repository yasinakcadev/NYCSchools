//
//  MockSchoolAPI.swift
//  SchoolNYCTests
//
//  Created by YASIN on 12.03.2023.
//

import Foundation
@testable import SchoolNYC

class MockSchoolAPI: SchoolAPIDirectory {
    var loadState: SchoolListLoadState = .empty
    
    func getSchoolSats(completion: @escaping ((Result<[SchoolNYC.SchoolSAT], SchoolNYC.DataError>) -> Void)) {
        switch loadState {
        case .loaded:
            let mockSAT = SchoolSAT(dbn: "", schoolName: "", numberOfSATTestTakers: "", criticalReadingAVGScore: "", mathAVGScore: "", writingAVGScore: "")
            completion(.success([mockSAT]))
        case .error:
            completion(.failure(.networkError("An error occured")))
        case .empty:
            completion(.success([]))
        }
    }
    
    func getSchools(completion: @escaping ((Result<[SchoolNYC.School]?, SchoolNYC.DataError>) -> Void)) {
        switch loadState {
        case .loaded:
            let mockSchool = School(dbn: "", schoolName: "", overviewParagraph: "", schoolEmail: "", academicOpportunities1: "", academicOpportunities2: "", neighborhood: "", phoneNumber: "", website: "", finalgrades: "", totalStudents: "", schoolSports: "", primaryAddressLine: "", city: "", zip: "", latitude: "", longitude: "")
            completion(.success([mockSchool]))
        case .error:
            completion(.failure(.networkError("An error occured")))
        case .empty:
            completion(.success([]))
        }
    }
  
}
