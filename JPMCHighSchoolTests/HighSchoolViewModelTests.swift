//
//  JPMCHighSchoolTests.swift
//  JPMCHighSchoolTests
//
//  Created by Anju Malhotra on 1/14/23.
//

import XCTest
@testable import JPMCHighSchool
import Combine

@MainActor
final class HighSchoolViewModelTests: XCTestCase {
    private var model: HighSchoolViewModel!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        model = HighSchoolViewModel(manager: APICreatorMock(urlString: "test"))
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        model = nil
    }
    
    func testGetSchoolData() throws {
        XCTAssertTrue(model.schools.isEmpty)
        model.getSchoolData()
        XCTAssertTrue(!model.schools.isEmpty)
    }
    
    func testGetSchoolData_WhenDataIsAlreayPresent() throws {
        XCTAssertTrue(model.schools.isEmpty)
        // Make API call
        model.getSchoolData()
        XCTAssertEqual(model.schools.count, 1)
        
        //API call doesnot happen when data is already present
        model.getSchoolData()
        XCTAssertEqual(model.schools.count, 1)
    }
    
    func testGetSATScores() throws {
        XCTAssertTrue(model.scores.isEmpty)
        model.getSATScores()
        XCTAssertTrue(!model.scores.isEmpty)
    }
    
    func testGetScoreData_WhenDataIsAlreayPresent() throws {
        XCTAssertTrue(model.scores.isEmpty)
        // Make API call
        model.getSATScores()
        XCTAssertEqual(model.scores.count, 1)
        
        //API call doesnot happen when data is already present
        model.getSATScores()
        XCTAssertEqual(model.scores.count, 1)
    }
    
    func testGetSATScoresFor_WhenScoreIsEmpty() throws {
        let score = model.getSatScoreFor("test")
        XCTAssertTrue(model.scores.isEmpty)
        XCTAssertNil(score)
    }
    
    func testGetSatScoreFor() throws {
        model.getSATScores()
        let score = model.getSatScoreFor("test")
        XCTAssertNotNil(score)
    }
    
    private class APICreatorMock: ApiCreator {
        var urlString: String
        init(urlString: String) {
            self.urlString = urlString
        }
        
        // Mock for getSchoolData and return publisher
        // Output: [HighSchool]
        // Error: HTTPError
        func getSchoolData() -> AnyPublisher<[JPMCHighSchool.HighSchool], JPMCHighSchool.HTTPError> {
            
            let highSchool = [HighSchool(dbn: "test", schoolName: "test", primaryAddressLine1: "test", city: "test", stateCode: "test", zip: "test", website: "test", totalStudents: "test")]
            return Just(highSchool)
                .setFailureType(to: HTTPError.self)
                .eraseToAnyPublisher()
        }
        
        
        // Mock for getScoreData and return publisher
        // Output: [HighSchool]
        // Error: HTTPError
        func getScoreData() -> AnyPublisher<JPMCHighSchool.SATScores, JPMCHighSchool.HTTPError> {
            let score = [SATScore(dbn: "test", schoolName: "test", numOfSatTestTakers: "test", satCriticalReadingAvgScore: "test", satMathAvgScore: "test", satWritingAvgScore: "test")]
            return Just(score)
                .setFailureType(to: HTTPError.self)
                .eraseToAnyPublisher()
        }
    }
}
