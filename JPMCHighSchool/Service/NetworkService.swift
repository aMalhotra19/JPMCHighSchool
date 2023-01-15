//
//  NetworkService.swift
//  JPMCHighSchool
//
//  Created by Anju Malhotra on 1/14/23.
//

import Foundation
import Combine

class NetworkService {
    static var shared: NetworkService = NetworkService()
    private init() {}
    
    func getData(url: URL) -> AnyPublisher<Data, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .mapError{ error in
                return error
            }
            .map(\.data)
            .eraseToAnyPublisher()
    }
    
}
