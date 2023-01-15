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
