//
//  SchoolNYCTests.swift
//  SchoolNYCTests
//
//  Created by YASIN on 7.03.2023.
//

import XCTest
import Combine
@testable import SchoolNYC

class SchoolNYCTests: XCTestCase {
    private var cancelables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    override func setUp() async throws {
        try await super.setUp()
        cancelables.removeAll()
    }
    
    func testMockSchoolAPIWithEmptyResult() {
        let expectation = expectation(description: "testing empty state with mock api")
        
        let mockAPI = MockSchoolAPI()
        mockAPI.loadState = .empty
        
        let viewModel = SchoolViewModel(api: mockAPI)
        viewModel.getSchools()
        
        viewModel.$schools.receive(on: RunLoop.main)
            .sink { schools in
                guard let schools = schools else {
                    XCTFail("expected to have schools")
                    return
                }
                XCTAssert(schools.isEmpty == true, "Expected to be empty but found data")
                expectation.fulfill()
            }
            .store(in: &cancelables)
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testMockSchoolAPIWithErrorResult() {
        let expectation = expectation(description: "testing error state with mock api")
        
        let mockAPI = MockSchoolAPI()
        mockAPI.loadState = .error
        
        let viewModel = SchoolViewModel(api: mockAPI)
        viewModel.getSchools()
        
        viewModel.$error.receive(on: RunLoop.main)
            .sink { error in
                if let error = error {
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
            }
            .store(in: &cancelables)
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testMockSchoolAPIWithSuccessResult() {
        let expectation = expectation(description: "testing success state with mock api")
        
        let mockAPI = MockSchoolAPI()
        mockAPI.loadState = .loaded
        
        let viewModel = SchoolViewModel(api: mockAPI)
        viewModel.getSchools()
        
        viewModel.$schools.receive(on: RunLoop.main)
            .sink { schools in
                if let schools = schools {
                    XCTAssert(schools.isEmpty == false, "Expected schools but came empty")
                    expectation.fulfill()
                }
            }
            .store(in: &cancelables)
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testMockSATAPIWithEmptyResult() {
        let expectation = expectation(description: "testing empty state with mock sat api")
        
        let mockAPI = MockSchoolAPI()
        mockAPI.loadState = .empty
        
        let viewModel = SchoolViewModel(api: mockAPI)
        viewModel.getSchoolSats()
        
        viewModel.$sats.receive(on: RunLoop.main)
            .sink { sats in
                if let sats = sats {
                    XCTAssert(sats.isEmpty == true, "expected to be empty but found data")
                    expectation.fulfill()
                }
            }
            .store(in: &cancelables)
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testMockSATAPIWithSuccessResult() {
        let expectation = expectation(description: "testing success state with mock sat api")
        
        let mockAPI = MockSchoolAPI()
        mockAPI.loadState = .loaded
        
        let viewModel = SchoolViewModel(api: mockAPI)
        viewModel.getSchoolSats()
        
        viewModel.$sats.receive(on: RunLoop.main)
            .sink { sats in
                if let sats = sats {
                    XCTAssert(sats.isEmpty == false, "expected to be sats but found nil")
                    expectation.fulfill()
                }
            }
            .store(in: &cancelables)
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testMockSATAPIWithErrorResult() {
        let expectation = expectation(description: "testing error state with mock sat api")
        
        let mockAPI = MockSchoolAPI()
        mockAPI.loadState = .error
        
        let viewModel = SchoolViewModel(api: mockAPI)
        viewModel.getSchoolSats()
        
        viewModel.$error.receive(on: RunLoop.main)
            .sink { error in
                if let error = error {
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                }
            }
            .store(in: &cancelables)
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
