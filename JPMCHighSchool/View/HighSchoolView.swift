//
//  HighSchoolView.swift
//  JPMCHighSchool
//
//  Created by Anju Malhotra on 1/15/23.
//

import SwiftUI

struct HighSchoolView: View {
    @ObservedObject var viewModel: HighSchoolViewModel
    var body: some View {
        Group {
            switch viewModel.schoolState {
            case .loading:
                ProgressView()
            case .success:
                loadDetailView()
                    .onAppear {viewModel.getSATScores()}
            case .failure(let error):
                ErrorView(error: error.localizedDescription)
            }
        }
    }
    
    @ViewBuilder
    func loadDetailView() -> some View {
        switch viewModel.scoreState {
        case .success:
            List {
                ForEach(viewModel.schools, id: \.dbn) { school in
                    NavigationLink {
                        if let score = viewModel.getSatScoreFor(school.dbn) {
                            SATDetailView(score: score)
                        } else {
                            ErrorView(error: Constants.noData)
                        }
                    } label: {
                        Text(school.schoolName)
                    }
                }
            }
        case .failure(_):
            Text(Constants.retryError)
        case .loading:
            ProgressView()
        }
    }
}

