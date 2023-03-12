//
//  SchoolAPIDirectory.swift
//  SchoolNYC
//
//  Created by YASIN on 7.03.2023.
//

import Foundation
import Alamofire

protocol SchoolAPIDirectory {
    func getSchools(completion: @escaping ((Result<[School]?,DataError>) -> Void))
    func getSchoolSats(completion: @escaping ((Result<[SchoolSAT],DataError>) -> Void))
}

class SchoolAPI: SchoolAPIDirectory {
    private struct Constants {
        static let schoolUrl  = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json?$$app_token=L1KwLSwm1yz1N7aWqFCF4dLmM"
        static let satUrl    = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?$$app_token=L1KwLSwm1yz1N7aWqFCF4dLmM"
    }
    
    func getSchools(completion: @escaping ((Result<[School]?, DataError>) -> Void)) {
        URLCache.shared.removeAllCachedResponses()
        AF.request(Constants.schoolUrl)
            .validate()
            .responseDecodable(of: [School].self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.failure(.networkError(error.localizedDescription)))
                case .success(let schools):
                    completion(.success(schools))
                }
            }
    }
    
    func getSchoolSats(completion: @escaping ((Result<[SchoolSAT], DataError>) -> Void)) {
        URLCache.shared.removeAllCachedResponses()
        AF.request(Constants.satUrl)
            .validate()
            .responseDecodable(of: [SchoolSAT].self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.failure(.networkError(error.localizedDescription)))
                case .success(let schoolSats):
                    print("gelen response \(response)")
                    completion(.success(schoolSats))
                }
            }
    }
}
