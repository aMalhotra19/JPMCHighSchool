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
    case failure(HTTPError)
}

class HighSchoolViewModel: ObservableObject {
    @Published var schools: [HighSchool] = []
    @Published var scores: SATScores = []
    @Published var score: SATScore?
    @Published private(set) var schoolState: State = .loading
    @Published private(set) var scoreState: State = .loading
    var cancellables = Set<AnyCancellable>()
    let manager: ApiCreator
    
    init(manager: ApiCreator = NetworkManager(urlString: Constants.urlHighSchool)) {
        self.manager = manager
    }
    
    ///getSchoolData:
    ///This function makes call to NetworkManager and recieves [HighSchool] DATA
    ///Updates Schools value
 
    @MainActor
    func getSchoolData() {
        if schools.count > 0 {
            return
        }
        schoolState = .loading
        manager.getSchoolData()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.schoolState = .failure(error)
                case .finished:
                    self?.schoolState = .success
                }
            }, receiveValue: { [weak self] schools in
                self?.schools = schools
            })
            .store(in: &cancellables)
    }
        
    ///getSATScores:
    ///This function makes call to NetworkManager and recieves SATAScore DATA
    ///Updates score value
    @MainActor
    func getSATScores() {
        if scores.count > 0 {
            return
        }
        scoreState = .loading
        manager.urlString = Constants.urlSatResult
        manager.getScoreData()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.scoreState = .failure(error)
                case .finished:
                    self?.scoreState = .success
                }
            }, receiveValue: { [weak self] scores in
                self?.scores = scores
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
