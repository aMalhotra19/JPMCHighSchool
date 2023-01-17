//
//  NetworkManagerTests.swift
//  JPMCHighSchoolTests
//
//  Created by Anju Malhotra on 1/16/23.
//

import XCTest
import Combine
@testable import JPMCHighSchool

final class NetworkManagerTests: XCTestCase {
    private var manager: NetworkManager!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        manager = NetworkManager(urlString: "https://www.google.com")
        cancellables = []
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        manager = nil
        cancellables = nil
    }

    func testGetSchoolData() throws {
        let result = manager.getSchoolData()
        var error: HTTPError?
        var responseData: [HighSchool] = []
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
        // correct error output:
        XCTAssertEqual(error, HTTPError.decodeError)
        XCTAssertTrue(responseData.isEmpty)
    }

    func testGetScoreData() throws {
        let result = manager.getScoreData()
        var error: HTTPError?
        var responseData: SATScores = []
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
        // correct error output:
        XCTAssertEqual(error, HTTPError.decodeError)
        XCTAssertTrue(responseData.isEmpty)
    }
}
