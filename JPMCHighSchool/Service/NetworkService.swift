//
//  NetworkService.swift
//  JPMCHighSchool
//
//  Created by Anju Malhotra on 1/14/23.
//

import Foundation
import Combine

final class NetworkService {
    //Shared class to make API calls and returns DATA returned from services
    static var shared: NetworkService = NetworkService()
    private init() {}
    
    ///getData:
    ///params: url
    ///This function makes api call
    ///returns DATA in case of success
    ///returns HTTPError in case of failure
 
    func getData(url: URL) -> AnyPublisher<Data, HTTPError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .mapError{ error in
                return error.errorCode == -1009 ? HTTPError.noInternet : HTTPError.unknown
            }
            .map(\.data)
            .eraseToAnyPublisher()
    }
    
}
