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
    @Published var schools: [HighSchool]
    @Published var scores: SATScores
    @Published var score: SATScore?
    @Published private(set) var schoolState: State
    @Published private(set) var scoreState: State
    var cancellables = Set<AnyCancellable>()
    var manager: NetworkManager
    
    init(schools: [HighSchool] = [], scores: SATScores = [], score: SATScore? = nil, schoolState: State = .loading, scoreState: State = .loading, manager: NetworkManager = NetworkManager(urlString: Constants.urlHighSchool)) {
        self.schools = schools
        self.scores = scores
        self.score = score
        self.schoolState = schoolState
        self.scoreState = scoreState
        self.manager = manager
    }
    
    func getSchoolData() {
        schoolState = .loading
        return manager.getSchoolData()
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
        if scores.count > 0 {
            return
        }
        scoreState = .loading
        manager.urlString = Constants.urlSatResult
        manager.getScoreData()
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

    @MainActor
    func getSatScoreFor(_ id: String) -> SATScore? {
        if scores.count > 0 {
            return scores.first { $0.dbn == id }
        }
        return nil
    }
}
