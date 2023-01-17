//
//  NetworkService.swift
//  JPMCHighSchoolTests
//
//  Created by Anju Malhotra on 1/16/23.
//

import XCTest
@testable import JPMCHighSchool
import Combine

final class NetworkServiceTests: XCTestCase {
    private var networkService: NetworkService!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkService = NetworkService.shared
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkService = nil
        cancellables = nil
    }
    
    func testGetData() throws {
        let result = networkService.getData(url: URL(string: "https://www.google.com")!)
        var error: Error?
        var responseData: Data? = nil
        let expectation = self.expectation(description: "Expectation")
        result
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let returnedError):
                    error = returnedError
                }
                
                // Fullfilling our expectation to unblock
                // our test execution:
                expectation.fulfill()
            } receiveValue: { data in
                responseData = data
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 10)
        
        // Asserting that our Combine pipeline yielded the
        // correct output:
        XCTAssertNil(error)
        XCTAssertNotNil(responseData)
    }
    
}
