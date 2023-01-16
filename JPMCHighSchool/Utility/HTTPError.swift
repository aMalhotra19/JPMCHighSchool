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
            return Constants.unknownError
        case .decodeError:
            return Constants.decodeError
        case .noInternet:
            return Constants.internetError
        }
    }
}
