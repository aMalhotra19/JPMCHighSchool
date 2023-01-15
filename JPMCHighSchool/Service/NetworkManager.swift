//
//  NetworkManager.swift
//  JPMCHighSchool
//
//  Created by Anju Malhotra on 1/14/23.
//

import Foundation
import Combine
protocol ApiCreator {
    var urlString: String { get }
}

class NetworkManager: ApiCreator {
    var urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func getData() -> AnyPublisher<[HighSchool], URLError> {
        guard let url = URL(string: urlString) else {fatalError()}
        return NetworkService.shared.getData(url: url)
            .flatMap { data in
                return Just(data)
                    .decode(type: [HighSchool].self, decoder: JSONDecoder())
                    .mapError({ _ in
                        URLError(.cannotDecodeRawData)
                    })
                    .eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
    func getData() -> AnyPublisher<SATScores, URLError> {
        guard let url = URL(string: urlString) else {fatalError()}
        return NetworkService.shared.getData(url: url)
            .flatMap { data in
                return Just(data)
                    .decode(type: SATScores.self, decoder: JSONDecoder())
                    .mapError({ _ in
                        URLError(.cannotDecodeRawData)
                    })
                    .eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
}
