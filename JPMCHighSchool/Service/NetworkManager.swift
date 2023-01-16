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
    
    // Contains API initialization, Session URL, JSON data decode,  getSchoolData function, getSchoolData function
    var urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }    
    
    ///getSchoolData:
    ///This function makes api call to NetworkService and recieves DATA
    ///Decodes the received data in [HighSchool]
    ///returns Publisher: Array of HighSchool and HTTPError
    
    func getSchoolData() -> AnyPublisher<[HighSchool], HTTPError> {
        guard let url = URL(string: urlString) else {fatalError()}
        return NetworkService.shared.getData(url: url)
            .flatMap { data in
                return Just(data)
                    .decode(type: [HighSchool].self, decoder: JSONDecoder())
                    .mapError({ _ in
                        return HTTPError.decodeError
                    })
                    .eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
    ///getScoreData:
    ///This function makes api call to NetworkService and recieves DATA
    ///Decodes the received data in SATScores
    ///returns Publisher: Array of SATScore and HTTPError
    
    func getScoreData() -> AnyPublisher<SATScores, HTTPError> {
        guard let url = URL(string: urlString) else {fatalError()}
        return NetworkService.shared.getData(url: url)
            .flatMap { data in
                return Just(data)
                    .decode(type: SATScores.self, decoder: JSONDecoder())
                    .mapError({ _ in
                        return HTTPError.decodeError
                    })
                    .eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
}
