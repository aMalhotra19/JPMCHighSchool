//
//  HighSchoolModel.swift
//  JPMCHighSchool
//
//  Created by Anju Malhotra on 1/14/23.
//

import Foundation

// MARK: - Welcome
struct HighSchool: Codable {
    let dbn, schoolName, primaryAddressLine1: String
    let city, stateCode, zip: String
    let website: String
    let totalStudents: String

    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case primaryAddressLine1 = "primary_address_line_1"
        case city
        case stateCode = "state_code"
        case zip, website
        case totalStudents = "total_students"
    }
}

// MARK: - SATScore
struct SATScore: Codable {
    let dbn, schoolName, numOfSatTestTakers, satCriticalReadingAvgScore: String
    let satMathAvgScore, satWritingAvgScore: String

    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case numOfSatTestTakers = "num_of_sat_test_takers"
        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case satMathAvgScore = "sat_math_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
    }
}

typealias SATScores = [SATScore]
