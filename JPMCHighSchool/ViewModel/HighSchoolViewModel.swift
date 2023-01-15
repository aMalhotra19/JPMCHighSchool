//
//  HighSchoolViewModel.swift
//  JPMCHighSchool
//
//  Created by Anju Malhotra on 1/14/23.
//

import Foundation
import Combine

enum State {
    case empty
    case success
    case failure(Error)
}

class HighSchoolViewModel: ObservableObject {
    @Published var schools: [HighSchool] = []
    @Published private(set) var state: State = State.empty
    var cancellables = Set<AnyCancellable>()
    
    func getData() {
        NetworkManager(urlString: "https://data.cityofnewyork.us/resource/7crd-d9xh.json").getData()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.state = .failure(error)
                case .finished:
                    self.state = .success
                }
            }, receiveValue: { schools in
                self.schools = schools
            })
            .store(in: &cancellables)
        
    }
}
