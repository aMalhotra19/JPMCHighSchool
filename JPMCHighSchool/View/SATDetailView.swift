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
        //Computed value from the dbn
        viewModel.getSatScoreFor(school.dbn)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            switch viewModel.scoreState {
                
                //Success case
            case .success:
                //when score is available
                if score != nil {
                    getScoreView()
                } else {
                    //when score is not available
                    ErrorView(error: Constants.noData, retryAction: nil)
                }
                
                //Failure case
            case .failure(let error):
                Text(error.localizedDescription)
                
                //API call in progress
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
