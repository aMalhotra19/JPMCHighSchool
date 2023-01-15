//
//  HighSchoolViewModel.swift
//  JPMCHighSchool
//
//  Created by Anju Malhotra on 1/14/23.
//

import Foundation
import Combine

enum State {
    case loading
    case success
    case failure(Error)
}

class HighSchoolViewModel: ObservableObject {
    @Published var schools: [HighSchool] = []
    @Published var scores: SATScores = []
    @Published var score: SATScore?
    @Published private(set) var schoolState: State = .loading
    @Published private(set) var scoreState: State = .loading
    var cancellables = Set<AnyCancellable>()
    
    func getSchoolData() {
        schoolState = .loading
        return NetworkManager(urlString: "https://data.cityofnewyork.us/resource/7crd-d9xh.json").getData()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.schoolState = .failure(error)
                case .finished:
                    self.schoolState = .success
                }
            }, receiveValue: { schools in
                self.schools = schools
            })
            .store(in: &cancellables)
            
    }
    
    func getSATScores() {
        scoreState = .loading
        NetworkManager(urlString: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json").getData()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.scoreState = .failure(error)
                case .finished:
                    self.scoreState = .success
                }
            }, receiveValue: { scores in
                self.scores = scores
            })
            .store(in: &cancellables)
    }

    func getSatScoreFor(_ id: String) -> SATScore? {
        if scores.count > 0 {
            return scores.first { $0.dbn == id }
        }
        return nil
    }
}
