//
//  HTTPError.swift
//  JPMCHighSchool
//
//  Created by Anju Malhotra on 1/15/23.
//

import Foundation

enum HTTPError: Error {
    case unknown
    case decodeError
    case noInternet
}

extension HTTPError {
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .decodeError:
            return "Decode Error code"
        case .noInternet:
            return "No internet connection"
        }
    }
}
