//
//  SATDetailView.swift
//  JPMCHighSchool
//
//  Created by Anju Malhotra on 1/15/23.
//

import SwiftUI

struct SATDetailView: View {
    var school: HighSchool
    @ObservedObject var viewModel: HighSchoolViewModel
    
    var score: SATScore? {
        viewModel.getSatScoreFor(school.dbn)
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            switch viewModel.scoreState {
            case .success:
                if score != nil {
                    getScoreView()
                } else {
                    ErrorView(error: Constants.noData)
                }
            case .failure(_):
                Text(Constants.retryError)
            case .loading:
                ProgressView()
            }
        }
        .padding(.leading, 20.0)
        .padding(.top, 10.0)
        .navigationTitle(Constants.satScoreTitle)
        .font(.subheadline)
        .onAppear {
            viewModel.getSATScores()
        }
    }
    
    @ViewBuilder
    func getScoreView() -> some View {
        VStack {
            HStack {
                Text(score?.schoolName ?? "")
                    .font(.title3)
                Spacer()
            }
            .padding(.bottom, 10)
            HStack {
                Text(Constants.writingScore)
                Text(score?.satWritingAvgScore ?? "")
                Spacer()
            }
            HStack {
                Text(Constants.mathScore)
                Text(score?.satMathAvgScore ?? "")
                Spacer()
            }
            HStack {
                Text(Constants.readingScore)
                Text(score?.satCriticalReadingAvgScore ?? "")
                Spacer()
            }
            Spacer()
        }
    }
}
